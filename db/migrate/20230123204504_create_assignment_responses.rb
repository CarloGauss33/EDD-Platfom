class CreateAssignmentResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :assignment_responses do |t|
      t.references :assignment, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.index [:assignment_id, :student_id], unique: true
      t.integer :status, default: 0
      t.text :comment
      t.timestamps
    end
  end
end
