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

  def self.update_with_omniauth(auth)
    omniauth_user(auth).tap do |user|
      user.update omniauth_attrs(auth)
    end
  end

  def self.create_from_slack(member)
    create! slack_attrs(member)
  end

  def self.omniauth_user(auth)
    find_by(uid: auth['uid']) || find_by(email: auth['info']['email'])
  end

  def self.omniauth_attrs(auth)
    {
      provider: auth['provider'],
      uid: auth['uid'],
      name: auth['info']['name'] || '',
      email: auth['info']['email'] || '',
      admin: auth['info']['is_admin'] || false,
      avatar: auth['info']['image'] || '',
    }
  end

  def self.slack_attrs(member)
    #TODO check it OUT!
    {
      provider: 'slack',
      uid: member['id'],
      name: member['profile']['real_name'] || '',
      email: member['profile']['email'] || '',
    }
  end
end
