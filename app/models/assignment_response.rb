class AssignmentResponse < ApplicationRecord
  after_update :notify_state_change

  belongs_to :assignment
  belongs_to :student

  has_many :assignment_question_responses, dependent: :destroy
  accepts_nested_attributes_for :assignment_question_responses, allow_destroy: true

  validates :assignment, presence: true
  validates :student, presence: true
  validates :student, uniqueness: { scope: :assignment }

  scope :by_assignment, ->(assignment_id) { where(assignment_id: assignment_id) }
  scope :by_student, ->(student_id) { where(student_id: student_id) }

  delegate :name, to: :assignment, prefix: true
  delegate :email, to: :student, prefix: true
  delegate :user, to: :student

  enum status: {
    pending: 0,
    submitted: 1,
    graded: 2,
    cancelled: 3
  }

  def self.by_assignment_and_student(assignment_id, student_id)
    by_assignment(assignment_id).by_student(student_id).first
  end

  def score
    assignment_question_responses.sum(&:score)
  end

  def last_updated_at
    assignment_question_responses.maximum(:updated_at)
  end

  private

  def notify_state_change
    return unless submitted?

    NotifyInterrogationUploadJob.perform_now(id)
    SendAnswerSummaryJob.perform_now(id)
  rescue StandardError => e
    Rails.logger.error e.message
    Rails.logger.error "Error sending notification for assignment response #{id}"
  end
end

# == Schema Information
#
# Table name: assignment_responses
#
#  id            :bigint(8)        not null, primary key
#  assignment_id :bigint(8)        not null
#  student_id    :bigint(8)        not null
#  status        :integer          default("pending")
#  comment       :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_assignment_responses_on_assignment_id                 (assignment_id)
#  index_assignment_responses_on_assignment_id_and_student_id  (assignment_id,student_id) UNIQUE
#  index_assignment_responses_on_student_id                    (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (assignment_id => assignments.id)
#  fk_rails_...  (student_id => students.id)
#
