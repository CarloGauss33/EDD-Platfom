class CodeHomeworkRun < ApplicationRecord
  TIMEOUT_BETWEEN_RUNS = 5.minutes
  belongs_to :code_homework
  belongs_to :student

  enum status: { pending: 0, running: 1, success: 2, failure: 3 }

  scope :by_student, ->(student) { where(student: student) }

  def self.last_student_run(student)
    by_student(student).order(:created_at).last
  end

  def self.student_able_to_run?(student)
    last_run = last_student_run(student)
    return true if last_run.nil?

    last_run.created_at < TIMEOUT_BETWEEN_RUNS.ago
  end
end

# == Schema Information
#
# Table name: code_homework_runs
#
#  id               :bigint(8)        not null, primary key
#  code_homework_id :bigint(8)        not null
#  student_id       :bigint(8)        not null
#  status           :integer          default("pending")
#  submitted_at     :datetime
#  graded_at        :datetime
#  run_results      :jsonb
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_code_homework_runs_on_code_homework_id  (code_homework_id)
#  index_code_homework_runs_on_student_id        (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (code_homework_id => code_homeworks.id)
#  fk_rails_...  (student_id => students.id)
#
