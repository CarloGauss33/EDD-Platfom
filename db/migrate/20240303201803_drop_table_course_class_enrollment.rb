class DropTableCourseClassEnrollment < ActiveRecord::Migration[6.1]
  def change
    drop_table :course_class_enrollments
  end
end
