class Assignment < ApplicationRecord
  before_save :set_start_date_on_active
  before_save :set_end_date_on_completed
  after_create_commit :create_assignment_responses

  has_many :assignment_questions, dependent: :destroy
  accepts_nested_attributes_for :assignment_questions, allow_destroy: true

  belongs_to :course
  has_many :assignment_responses, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :course_id }
  validate :unique_active_exam_on_course?, on: :create

  def self.with_active_semester
    where(course: Course.active).distinct
  end

  enum status: {
    pending: 0,
    active: 1,
    completed: 2,
    cancelled: 3
  }

  enum kind: {
    exam: 0,
    homework: 1,
    quiz: 2,
    other: 3
  }

  def self.on_active_course
    joins(:course).where(courses: { status: :active }).distinct
  end

  scope :active, -> { where(status: :active) }

  private

  def unique_active_exam_on_course?
    return unless exam? && active?
    return unless course.assignments.exam.active.count.positive?

    errors.add(:course, "can't have more than one active exam")
  end

  def set_start_date_on_active
    return unless active? && start_date.nil?

    self.start_date = Time.zone.now
  end

  def set_end_date_on_completed
    return unless completed? && end_date.nil?

    self.end_date = Time.zone.now
  end

  def create_assignment_responses
    course.students.each do |student|
      assignment_responses.create(student: student)
    end
  end
end

# == Schema Information
#
# Table name: assignments
#
#  id                      :bigint(8)        not null, primary key
#  course_id               :bigint(8)        not null
#  name                    :string
#  description             :string
#  weight                  :float
#  assignment_url          :string
#  assignment_solution_url :string
#  status                  :integer          default("pending")
#  kind                    :integer          default("exam")
#  number_of_questions     :integer
#  responses_required      :boolean
#  start_date              :datetime
#  end_date                :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_assignments_on_course_id  (course_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#
