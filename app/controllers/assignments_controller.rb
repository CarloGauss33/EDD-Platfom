class AssignmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @assignment = Assignment.last
    @assignment_questions = assignment_questions
    @course = course
    @assignment_question_responses = assignment_question_responses
  end

  def show
    @assignment = Assignment.find(params[:id])
  end

  private

  def assignment_questions
    @assignment_questions = @assignment.assignment_questions
  end

  def course
    @course = @assignment.course
  end

  def student
    @student = Student.by_course_and_user(course.id, current_user.id)
  end

  def assignment_response
    @assignment_response = AssignmentResponse.by_assignment_and_student(@assignment.id, student.id)
  end

  def assignment_question_responses
    @assignment_question_responses = assignment_response.assignment_question_responses
  end
end
