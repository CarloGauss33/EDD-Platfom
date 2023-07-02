class AssignmentResponsesController < ApplicationController
  before_action :authenticate_user!

  def show
    @assignment = assignment
    @assignment_response = assignment_response
    @course = course
    @assignment_question_responses = assignment_question_responses
    @is_new_response = new_response?
  end

  private

  def assignment
    @assignment = current_user.assignments.find(params[:assignment_id])
  end

  def course
    @course = assignment.course
  end

  def student
    @student = Student.by_course_and_user(course.id, current_user.id)
  end

  def assignment_response
    @assignment_response = AssignmentResponse.by_assignment_and_student(assignment.id, student.id)
  end

  def assignment_question_responses
    @assignment_question_responses =
      assignment_response.assignment_question_responses
      .order(:assignment_question_id)
  end

  def updated_on_the_same_day
    @updated_on_the_same_day = assignment_response.updated_at.to_date == Time.zone.today
  end

  def new_response?
    assignment_response.submitted? && updated_on_the_same_day
  end
end
