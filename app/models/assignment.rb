class Assignment < ApplicationRecord
  before_save :set_start_date_on_active
  before_save :set_end_date_on_completed

  belongs_to :course

  validates :name, presence: true, uniqueness: { scope: :course_id }
  validate :unique_active_exam_on_course?

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
