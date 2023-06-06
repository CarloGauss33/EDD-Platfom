class SyncSubmittedResponsesForAssignmentJob < ApplicationJob
  queue_as :default

  def perform(assignment_id)
    @assignment_id = assignment_id
    return unless assignment.present? && non_submitted_responses.any?

    non_submitted_responses_with_inconsistent_status.find_in_batches do |responses|
      responses.map(&:submitted!)
    end
  end

  private

  def assignment
    @assignment ||= Assignment.find_by(id: @assignment_id)
  end

  def assignment_responses
    @assignment_responses ||= AssignmentResponse.by_assignment(assignment.id)
  end

  def non_submitted_responses
    @non_submitted_responses ||= assignment_responses.where.not(status: :submitted)
  end

  def non_submitted_responses_with_inconsistent_status
    @non_submitted_responses_with_inconsistent_status ||=
      non_submitted_responses
      .joins(:assignment_question_responses)
      .where(assignment_question_responses: { status: :submitted })
  end
end
