class CreateQuestionAnswerLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :question_answer_logs do |t|
      t.integer :caller_platform
      t.string :caller_id
      t.text :question
      t.text :answer
      t.integer :answer_origin
      t.timestamps
    end
  end
end
