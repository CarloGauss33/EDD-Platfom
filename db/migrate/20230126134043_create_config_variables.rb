class CreateConfigVariables < ActiveRecord::Migration[6.1]
  def change
    create_table :config_variables do |t|
      t.string :name, null: false
      t.string :key, null: false
      t.integer :value_type, null: false
      t.string :value
      t.string :description
      t.timestamps
    end
  end
end
