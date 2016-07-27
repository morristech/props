class AddSlackTsToProps < ActiveRecord::Migration
  def change
    add_column :props, :slack_ts, :string
  end
end
