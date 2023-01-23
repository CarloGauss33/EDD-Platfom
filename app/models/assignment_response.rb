class AssignmentResponse < ApplicationRecord
  belongs_to :assignment
  belongs_to :student

  has_many :assignment_question_responses, dependent: :destroy
  accepts_nested_attributes_for :assignment_question_responses, allow_destroy: true

  validates :assignment, presence: true
  validates :student, presence: true
  validates :student, uniqueness: { scope: :assignment }

  enum status: {
    pending: 0,
    submitted: 1,
    graded: 2,
    cancelled: 3
  }

  def score
    assignment_question_responses.sum(&:score)
  end

  def last_updated_at
    assignment_question_responses.maximum(:updated_at)
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
