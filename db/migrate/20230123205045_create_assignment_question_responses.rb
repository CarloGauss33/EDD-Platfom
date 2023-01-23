class CreateAssignmentQuestionResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :assignment_question_responses do |t|
      t.references :assignment_response, null: false, foreign_key: true
      t.references :assignment_question, null: false, foreign_key: true
      t.index [:assignment_question_id, :assignment_response_id], unique: true, name: 'index_question_responses_on_question_id_and_response_id'
      t.float :score, default: 0.0
      t.string :description
      t.jsonb :file_data, default: {}
      t.integer :status, default: 0
      t.text :comment
      t.timestamps
    end
  end
end
