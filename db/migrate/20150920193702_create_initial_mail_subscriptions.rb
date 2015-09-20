class CreateInitialMailSubscriptions < ActiveRecord::Migration
  def up
    User.where(archived_at: nil).pluck(:id).each do |user_id|
      MailSubscription.create!(user_id: user_id)
    end
  end

  def down; end
end
