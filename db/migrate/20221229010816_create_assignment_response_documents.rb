class CreateAssignmentResponseDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :assignment_response_documents do |t|
      t.references :assignment_response, null: false, foreign_key: true
      t.float :score
      t.string :description
      t.jsonb :file_data
      t.timestamps
    end
  end
end
