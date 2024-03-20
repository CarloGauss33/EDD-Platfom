class Api::Internal::CodeHomeworkRunsController < Api::Internal::BaseController
  def create
    return respond_with create_code_homework_run if able_to_run?

    respond_with 'You must wait until performing this action', status: :unprocessable_entity
  end

  private

  def able_to_run?
    CodeHomeworkRun.student_able_to_run?(student)
  end

  def create_code_homework_run
    student.code_homework_runs.create!(code_homework: code_homework)
  end

  def code_homework
    @code_homework = course.code_homeworks.find(params[:code_homework_id])
  end

  def course
    @course ||= Course.current
  end

  def student
    @student = Student.by_course_and_user(course.id, current_user.id)
  end
end
