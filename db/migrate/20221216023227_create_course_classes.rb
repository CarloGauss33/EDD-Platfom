class CreateCourseClasses < ActiveRecord::Migration[6.1]
  def change
    create_table :course_classes do |t|
      t.references :course, null: false, foreign_key: true
      t.integer :section
      t.string :canvas_course_id
      t.string :professor_name
      t.string :professor_email
      t.timestamps
    end
  end
end
