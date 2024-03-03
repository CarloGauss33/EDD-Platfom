class Assignment::CreatePendingResponsesJob < ApplicationJob
  queue_as :default

  def perform(assignment:)
    return if assignment.blank? || assignment.completed?

    @assignment = assignment
    AssignmentResponse.import! records, on_duplicate_key_ignore: true
  end

  private

  def course
    @course ||= @assignment.course
  end

  def student_ids
    @student_ids ||= course.students.pluck(:id)
  end

  def records
    student_ids.map do |student_id|
      {
        assignment_id: @assignment.id,
        student_id: student_id
      }
    end
  end
end
