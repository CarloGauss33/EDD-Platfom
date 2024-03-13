class CreateCodeHomeworkRuns < ActiveRecord::Migration[6.1]
  def change
    create_table :code_homework_runs do |t|
      t.references :code_homework, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.integer :status, default: 0
      t.datetime :submitted_at
      t.datetime :graded_at
      t.jsonb :run_results

      t.timestamps
    end
  end
end
