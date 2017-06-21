class User < ActiveRecord::Base
  validates :name, presence: true
  validates :uid, uniqueness: { scope: :provider }
  has_many :props, through: :prop_receivers
  has_many :prop_receivers
  has_many :memberships
  has_many :organisations, through: :memberships

  def to_s
    name
  end

  def self.create_with_omniauth(auth)
    return update_with_omniauth(auth) if omniauth_user(auth)
    create! omniauth_attrs(auth)
  end

  def self.create_with_slack_fetch(user_info)
    return update_with_slack_fetch(user_info) if slack_user(user_info)
    create! slack_fetch_attrs(user_info)
  end

  def self.update_with_omniauth(auth)
    omniauth_user(auth).tap do |user|
      user.update omniauth_attrs(auth)
    end
  end

  def self.update_with_slack_fetch(user_info)
    slack_user(user_info).tap do |user|
      user.update slack_fetch_attrs(user_info)
    end
  end

  def self.create_from_slack(member)
    create! slack_attrs(member)
  end

  def self.omniauth_user(auth)
    find_by(uid: auth['uid']) || find_by(email: auth['info']['email'])
  end

  def self.slack_user(user_info)
    find_by(uid: user_info['id']) || find_by(email: user_info['profile']['email'])
  end

  def self.omniauth_attrs(auth)
    {
      provider: auth['provider'],
      uid: auth['uid'],
      name: auth['info']['name'] || '',
      email: auth['info']['email'] || '',
      admin: auth['info']['is_admin'] || false,
      avatar: big_avatar_512(auth) || small_avatar_192(auth),
    }
  end

  def self.slack_fetch_attrs(user_info)
    {
      provider: 'slack',
      uid: user_info['id'],
      name: name_from_user_info(user_info),
      email: user_info['profile']['email'] || '',
      admin: user_info['is_admin'] || false,
      avatar: user_info['profile']['image_512'],
    }
  end

  def self.slack_attrs(member)
    # TODO: check this OUT! It may be obsolete code.
    {
      provider: 'slack',
      uid: member['id'],
      name: member['profile']['real_name'] || '',
      email: member['profile']['email'] || '',
    }
  end

  class << self
    private

    def big_avatar_512(auth)
      auth.dig('extra', 'user_info', 'user', 'profile', 'image_512')
    end

    def small_avatar_192(auth)
      auth['info']['image']
    end

    def name_from_user_info(user_info)
      user_info['real_name'].blank? ? user_info['name'] : user_info['real_name']
    end
  end
end
