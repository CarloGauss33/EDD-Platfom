class AddDefaultInscriptionToCourseClass < ActiveRecord::Migration[6.1]
  def change
    add_column :course_classes, :default_inscription, :boolean, default: false
  end
end
