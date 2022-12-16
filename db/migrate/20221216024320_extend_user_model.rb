class ExtendUserModel < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :names, :string
    add_column :users, :last_names, :string
    add_column :users, :status, :integer, default: 0
    add_column :users, :canvas_user_id, :string
    add_column :users, :university_id, :string
    add_column :users, :rut, :string
    add_column :users, :github_username, :string
  end
end
