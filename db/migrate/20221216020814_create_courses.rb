class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :code
      t.string :description
      t.integer :status, default: 0
      t.integer :season, default: 0
      t.integer :year, default: 2023
      t.string :administrator_email
      t.timestamps
    end
  end
end
