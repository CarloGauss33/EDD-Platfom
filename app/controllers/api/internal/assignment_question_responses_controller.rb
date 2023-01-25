class Api::Internal::AssignmentQuestionResponsesController < Api::Internal::BaseController
  before_action :authenticate_user!

  def create
    if assignment_question_response.present?
      assignment_question_response.update!(assignment_question_response_params)
      respond_with assignment_question_response.reload
    else
      respond_with assignment_response.assignment_question_responses.create!(
        assignment_question_response_params.merge(
          assignment_question: assignment_question
        )
      )
    end
  end

  def update
    assignment_question_response.update!(assignment_question_response_params)
    respond_with assignment_question_response.reload
  end

  private

  def assignment_question_response
    @assignment_question_response ||= assignment_response
                                      .assignment_question_responses
                                      .find_by(assignment_question_id: assignment_question.id)
  end

  def course
    @course ||= Course.find_by!(id: params[:course_id])
  end

  def student
    @student ||= Student.by_course_and_user(course, current_user)
  end

  def assignment
    @assignment ||= course.assignments.find_by!(id: params[:assignment_id])
  end

  def assignment_response
    @assignment_response ||= student.assignment_responses.find_by!(assignment_id: assignment.id)
  end

  def assignment_question
    @assignment_question ||= assignment.assignment_questions.find_by!(id: params[:assignment_question_id])
  end

  def assignment_question_response_params
    params.require(:assignment_question_response).permit(
      :description,
      :file,
      :comment
    )
  end
end
