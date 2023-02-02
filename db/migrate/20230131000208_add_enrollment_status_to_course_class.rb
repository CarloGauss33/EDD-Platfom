class AddEnrollmentStatusToCourseClass < ActiveRecord::Migration[6.1]
  def change
    add_column :course_classes, :enrollments_loaded_at, :datetime
  end
end
