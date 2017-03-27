class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string :name, null: false
      t.string :subdomain, null: false, index: { unique: true }

      t.timestamps null: false
    end
  end
end
