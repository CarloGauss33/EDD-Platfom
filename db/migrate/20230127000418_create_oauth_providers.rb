class CreateOauthProviders < ActiveRecord::Migration[6.1]
  def change
    create_table :oauth_providers do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :provider, null: false
      t.string :uid, null: false
      t.timestamps
    end
  end
end
