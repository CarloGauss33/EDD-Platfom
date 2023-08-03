class CreateCourseInformationModules < ActiveRecord::Migration[6.1]
  def change
    create_table :course_information_modules do |t|
      t.references :course, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.integer :position
      t.boolean :visible, default: true
      t.timestamps
    end
  end
end
