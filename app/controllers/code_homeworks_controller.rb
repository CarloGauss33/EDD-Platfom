class CodeHomeworksController < ApplicationController
  before_action :authenticate_user!

  def index
    @code_homeworks = code_homeworks
  end

  def show
    @code_homework = code_homework
    @code_homework_runs = code_homework_runs
  end

  private

  def code_homework
    @code_homework = course.code_homeworks.find(params[:id])
  end

  def code_homework_runs
    @code_homework_runs = student
                          .code_homework_runs
                          .where(code_homework: code_homework)
                          .sort_by(&:created_at)
  end

  def code_homeworks
    @code_homeworks = course.code_homeworks
  end

  def course
    @course ||= Course.current
  end

  def student
    @student = Student.by_course_and_user(course.id, current_user.id)
  end
end
