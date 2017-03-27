class StoreSlackDataUnderUserAndOrganisation < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :image_url, :string
    add_column :users, :slack_uid, :string
    add_column :users, :slack_token, :string
    add_column :users, :slack_token_expires, :datetime
    add_index :users, :slack_uid, unique: true

    add_column :organisations, :slack_uid, :string
    add_column :organisations, :image_url, :string
    add_index :organisations, :slack_uid, unique: true
  end
end
