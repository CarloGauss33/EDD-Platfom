class Api::Internal::AssignmentQuestionResponsesController < Api::Internal::BaseController
  before_action :authenticate_user!
  before_action :check_assignment_enabled, only: %i[create update]

  def create
    return respond_with_updated_response if assignment_question_response.present?

    respond_with create_assignment_question_response
  end

  def update
    respond_with_updated_response
  end

  private

  def respond_with_updated_response
    assignment_question_response.update!(assignment_question_response_params)
    respond_with assignment_question_response.reload
  end

  def create_assignment_question_response
    assignment_response.assignment_question_responses.create!(
      assignment_question_response_params.merge(assignment_question: assignment_question)
    )
  end

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
    @assignment ||= course.assignments.find(params[:assignment_id])
  end

  def assignment_response
    @assignment_response ||= student.assignment_responses.find_by!(
      assignment_id: assignment.id
    )
  end

  def assignment_question
    @assignment_question ||= assignment.assignment_questions.find_by!(
      id: params[:assignment_question_id]
    )
  end

  def assignment_question_response_params
    params.require(:assignment_question_response).permit(
      :description,
      :file,
      :comment
    )
  end

  def assignment_enabled?
    assignment.active?
  end

  def check_assignment_enabled
    return if assignment_enabled?

    respond_with assignment, status: :unprocessable_entity
  end
end
