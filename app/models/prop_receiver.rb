# == Schema Information
#
# Table name: prop_receivers
#
#  id      :integer          not null, primary key
#  prop_id :integer
#  user_id :integer
#

class PropReceiver < ActiveRecord::Base
  belongs_to :prop
  belongs_to :user

  validates :prop, :user, presence: true
  validate :active_user?, on: :create

  private

  def active_user?
    return if user.archived_at.nil?
    errors.add(:user_id, I18n.t('props.errors.archived_user', name: user.name))
  end
end
