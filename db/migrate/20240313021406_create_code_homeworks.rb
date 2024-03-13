class CreateCodeHomeworks < ActiveRecord::Migration[6.1]
  def change
    create_table :code_homeworks do |t|
      t.references :course, null: false, foreign_key: true
      t.string :name
      t.string :homework_url
      t.datetime :start_date
      t.datetime :end_date
      t.string :repository_prefix
      t.string :template_repository_url
      t.string :solution_repository_url
      t.string :testcases_url

      t.timestamps
    end
  end
end
