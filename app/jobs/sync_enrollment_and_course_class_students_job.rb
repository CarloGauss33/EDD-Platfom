class SyncEnrollmentAndCourseClassStudentsJob < ApplicationJob
  queue_as :default

  def perform(course_class_id)
    @course_class = CourseClass.find_by(id: course_class_id)

    return if @course_class.nil?

    course_class_enrollments.each do |course_class_enrollment|
      next if course_class_enrollment.user.nil?

      @course_class.students.create(user: course_class_enrollment.user)
    end
  end

  private

  def course_class_enrollments
    @course_class_enrollments ||= @course_class.course_class_enrollments
  end
end
