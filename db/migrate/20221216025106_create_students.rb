class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course_class, null: false, foreign_key: true
      t.integer :status, default: 0
      t.string :canvas_enrollment_id
      t.timestamps
    end
  end
end
