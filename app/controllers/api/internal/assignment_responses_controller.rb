class Api::Internal::AssignmentResponsesController < Api::Internal::BaseController
  before_action :authenticate_user!

  def update
    assignment_response.submitted!
    respond_with assignment_response
  end

  private

  def course
    @course ||= Course.find_by!(id: params[:course_id])
  end

  def assignment
    @assignment ||= course.assignments.find(params[:assignment_id])
  end

  def student
    @student ||= Student.by_course_and_user(course, current_user)
  end

  def assignment_response
    @assignment_response ||= student.assignment_responses.find_by!(assignment_id: assignment.id)
  end
end
