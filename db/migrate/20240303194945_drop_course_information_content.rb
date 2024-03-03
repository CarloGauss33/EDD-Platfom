class DropCourseInformationContent < ActiveRecord::Migration[6.1]
  def change
    drop_table :course_information_contents
  end
end
