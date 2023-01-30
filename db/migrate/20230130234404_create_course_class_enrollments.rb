class CreateCourseClassEnrollments < ActiveRecord::Migration[6.1]
  def change
    create_table :course_class_enrollments do |t|
      t.references :course_class, null: false, foreign_key: true
      t.string :email
      t.string :rut
      t.string :university_id
      t.string :enrollment_id
      t.string :full_name
      t.timestamps
    end
  end
end
