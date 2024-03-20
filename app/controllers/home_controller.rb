class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @assignments = active_courses_assignments.order(end_date: :desc).includes(:course)
    @code_homeworks = code_homeworks
  end

  private

  def code_homeworks
    @code_homeworks = course.code_homeworks
  end

  def active_courses_assignments
    @active_courses_assignments = current_user.assignments.on_active_course
  end

  def submitted_assignment_responses
    @submitted_assignment_responses = current_user.assignment_responses.submitted
  end

  def course
    @course ||= Course.current
  end

  def student
    @student = Student.by_course_and_user(course.id, current_user.id)
  end
end
