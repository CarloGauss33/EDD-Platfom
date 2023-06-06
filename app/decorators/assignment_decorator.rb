class AssignmentDecorator < Draper::Decorator
  delegate_all

  def submitted_responses_count
    object.assignment_responses.submitted.count
  end

  def non_submitted_responses_count
    object.assignment_responses.not_submitted.count
  end
end
