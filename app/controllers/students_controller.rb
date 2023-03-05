class StudentsController < ApplicationController
  def new
    @course_classes = course.course_classes
    @course = course
  end

  private

  def course
    @course ||= Course.find(params[:course_id])
  end
end
