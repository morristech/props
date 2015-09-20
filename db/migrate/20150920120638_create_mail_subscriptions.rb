class CreateMailSubscriptions < ActiveRecord::Migration
  def change
    create_table :mail_subscriptions do |t|
      t.integer :user_id
      t.string :interval, default: :daily
      t.datetime :last_sent_at
      t.boolean :active, default: :true

      t.timestamps null: false
    end

    add_index :mail_subscriptions, :user_id, unique: true
  end
end
