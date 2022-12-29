class CreateAssignmentResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :assignment_responses do |t|
      t.references :assignment, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.integer :status
      t.float :final_score
      t.timestamps
    end
  end
end
