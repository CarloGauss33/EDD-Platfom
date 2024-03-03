class RemoveEnrollmentLoadedAtFromCourseClass < ActiveRecord::Migration[6.1]
  def change
    safety_assured { remove_column :course_classes, :enrollments_loaded_at, :datetime }
  end
end
