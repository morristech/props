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

  delegate :find_by_email, to: :active

  def user_from_auth(auth)
    active.where(
      provider: auth['provider'],
      uid: auth['uid'].to_s,
    ).first || User.create_with_omniauth(auth)
  end

  def user_from_slack(member)
    find_by_email(member['profile']['email']) || User.create_from_slack(member)
  end
end
