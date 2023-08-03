class CreateCourseInformationContents < ActiveRecord::Migration[6.1]
  def change
    create_table :course_information_contents do |t|
      t.references :course_information_module, null: false, foreign_key: true,
        index: { name: 'index_course_information_contents_on_module_id' }
      t.string :name
      t.text :description
      t.integer :position
      t.boolean :visible, default: true
      t.timestamps
    end
  end
end
