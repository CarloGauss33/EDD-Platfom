class CreateAssignment < ActiveRecord::Migration[6.1]
  def change
    create_table :assignments do |t|
      t.references :course, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.float :weight
      t.string :assignment_url
      t.string :assignment_solution_url
      t.integer :status, default: 0
      t.integer :kind, default: 0
      t.integer :number_of_questions
      t.boolean :responses_required
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
