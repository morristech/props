class UsersRepository
  def all
    User.all.order(:name)
  end

  def active
    all.where('archived_at IS NULL')
  end

  def find_by_id(id)
    all.find(id)
  end

  delegate :find_by_email, :find_by_name, to: :all

  def user_from_auth(auth)
    active.where(
      provider: auth['provider'],
      uid: auth['uid'].to_s,
    ).first || User.create_with_omniauth(auth)
  end

  def user_from_slack(member)
    find_by_member(member) || User.create_from_slack(member)
  end

  def find_by_member(member)
    find_by_slack_email(member['profile']['email']) || find_by_name(member['profile']['real_name'])
  end

  def find_by_slack_email(email)
    local = email.split('@').first
    emails = [email] | AppConfig.extra_domains.split(',').map { |domain| "#{local}@#{domain.strip}" }

    all.where(email: emails).first
  end
end
