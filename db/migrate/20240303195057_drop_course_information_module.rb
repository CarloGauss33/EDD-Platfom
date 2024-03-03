class DropCourseInformationModule < ActiveRecord::Migration[6.1]
  def change
    drop_table :course_information_modules
  end
end
