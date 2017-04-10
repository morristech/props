class UsersRepository
  def all
    User.all.order(:name)
  end

  def for_organisation(organisation)
    User.where(
      id: active.select(:id).joins(:organisations).where('organisations.id = ?', organisation.id),
    )
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
    find_by_member(member) || (report_matching_error(member) && User.create_from_slack(member))
  end

  private

  def allowed_domains
    AppConfig.extra_domains.to_s.split(',') << AppConfig.domain_name.to_s
  end

  def find_by_member(member)
    find_by_slack_email(member['profile']['email']) || find_by_name(member['profile']['real_name'])
  end

  def find_by_slack_email(email)
    local = email.split('@').first
    emails = [email] | allowed_domains.map { |domain| "#{local}@#{domain.strip}" }

    all.where(email: emails).first
  end

  def report_matching_error(member)
    Rollbar.error("Couldn't match slack member: #{member}")
  end
end
