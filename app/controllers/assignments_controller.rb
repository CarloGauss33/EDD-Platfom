class AssignmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @assignments = active_courses_assignments.order(end_date: :desc).includes(:course)
    @submitted_assignment_responses = submitted_assignment_responses
    @on_active_course = current_user.on_active_course?
  end

  def show
    @assignment = assignment
    @assignment_questions = assignment_questions
    @course = course
    @assignment_question_responses = assignment_question_responses
  end

  private

  def assignment
    @assignment = current_user.assignments.find(params[:id])
  end

  def active_courses_assignments
    @active_courses_assignments = current_user.assignments.on_active_course
  end

  def assignment_questions
    @assignment_questions = assignment.assignment_questions
  end

  def submitted_assignment_responses
    @submitted_assignment_responses = current_user.assignment_responses.submitted
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
    @assignment_question_responses = assignment_response.assignment_question_responses
  end
end
