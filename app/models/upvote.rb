# == Schema Information
#
# Table name: upvotes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  prop_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Upvote < ActiveRecord::Base
  belongs_to :user
  belongs_to :prop, counter_cache: true

  validates :user_id, uniqueness: { scope: :prop_id }
  validates :user_id, :prop_id, presence: true
  validate :can_upvote?, on: :create

  private

  def can_upvote?
    return unless user.present? && prop.users.include?(user)
    errors.add(:user_id, "You can't upvote your own prop!")
  end
end
