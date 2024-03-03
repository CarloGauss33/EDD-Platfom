class DropQuestionAnswerLogTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :question_answer_logs
  end
end
