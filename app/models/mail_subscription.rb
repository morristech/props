# == Schema Information
#
# Table name: mail_subscriptions
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  interval     :string           default("daily")
#  last_sent_at :datetime
#  active       :boolean          default(TRUE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class MailSubscription < ActiveRecord::Base
  belongs_to :user
end
