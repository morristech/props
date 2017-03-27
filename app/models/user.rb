# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  name                :string
#  email               :string
#  provider            :string
#  uid                 :string
#  created_at          :datetime
#  updated_at          :datetime
#  admin               :boolean          default(FALSE)
#  archived_at         :datetime
#  organisation_id     :integer
#  first_name          :string
#  last_name           :string
#  image_url           :string
#  slack_uid           :string
#  slack_token         :string
#  slack_token_expires :datetime
#

class User < ActiveRecord::Base
  validates :name, presence: true
  validates :uid, uniqueness: { scope: :provider }
  belongs_to :organisation
  has_many :props, through: :prop_receivers
  has_many :prop_receivers

  def to_s
    name
  end

  def self.create_with_omniauth(auth)
    return update_with_omniauth(auth) if omniauth_user(auth)
    create! omniauth_attrs(auth)
  end

  def self.update_with_omniauth(auth)
    omniauth_user(auth).tap do |user|
      user.update omniauth_attrs(auth)
    end
  end

  def self.create_from_slack(member)
    create! slack_attrs(member)
  end

  def self.omniauth_user(auth)
    find_by_email(auth['info']['email']) || find_by_name(auth['info']['name'])
  end

  def self.omniauth_attrs(auth)
    {
      provider: auth['provider'],
      uid: auth['uid'],
      name: auth['info']['name'] || '',
      email: auth['info']['email'] || '',
    }
  end

  def self.slack_attrs(member)
    {
      provider: 'slack',
      uid: member['id'],
      name: member['profile']['real_name'] || '',
      email: member['profile']['email'] || '',
    }
  end
end
