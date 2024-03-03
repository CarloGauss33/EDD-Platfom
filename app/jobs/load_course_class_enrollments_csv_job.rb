require 'csv'

class LoadCourseClassEnrollmentsCsvJob < ApplicationJob
  queue_as :default

  def perform(course_class_id, csv_file)
    course_class = CourseClass.find(course_class_id)

    return unless csv_file.present? && course_class.present?

    CourseClassEnrollment.transaction do
      CSV.foreach(csv_file.path, headers: true) do |row|
        CourseClassEnrollment.create!(
          course_class: course_class,
          email: row['email'],
          rut: row['rut'],
          university_id: row['university_id'],
          enrollment_id: row['enrollment_id'],
          full_name: row['full_name']
        )
      end

      course_class.update!(enrollments_loaded_at: Time.zone.now)
    end
  end
end
