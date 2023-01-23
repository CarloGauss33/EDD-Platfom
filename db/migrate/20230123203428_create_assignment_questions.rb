class CreateAssignmentQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :assignment_questions do |t|
      t.references :assignment, null: false, foreign_key: true
      t.integer :question_type
      t.string :title
      t.string :description
      t.timestamps
    end
  end
end
