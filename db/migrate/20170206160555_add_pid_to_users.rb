class AddPidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :player_id, :string
  end
end
