class Api::Internal::StudentsController < Api::Internal::BaseController
  def create
    respond_with CreateUserFromStudentJob.perform_now(user_params, course_class.id)
  end

  private

  def user_params
    params.require(:student).require(:user).permit(
      :email,
      :names,
      :last_names,
      :university_id,
      :rut,
      :github_username
    )
  end

  def course_class
    @course_class ||= CourseClass.find(params[:course_class_id])
  end
end
