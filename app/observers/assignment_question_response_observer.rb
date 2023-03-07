class AssignmentQuestionResponseObserver < PowerTypes::Observer
  after_save :update_assignment_response

  def update_assignment_response
    assignment_response.submitted! if assignment_response.pending?
  end

  private

  def assignment_response
    @assignment_response ||= object.assignment_response
  end
end
