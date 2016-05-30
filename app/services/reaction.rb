class Reaction
  pattr_initialize :reaction, :ts, :uid

  def upvote
    vote Props::Upvote
  end

  def undo_upvote
    vote Props::UndoUpvote
  end

  def propser
    users_repository.user_from_slack(user_profile(uid))
  end

  def prop
    props_repository.find_by_slack_ts(ts)
  end

  private

  def vote(voting_service)
    return unless prop.present?

    voting_service.new(
      prop: prop,
      user: propser,
      upvotes_repository: upvotes_repository,
    ).call
  end

  def user_profile(id)
    Slack::RealTime::Client.new.web_client.users_list.fetch(:members).detect do |member|
      member.fetch(:id) == id
    end
  end

  def upvotes_repository
    UpvotesRepository.new
  end

  def users_repository
    UsersRepository.new
  end

  def props_repository
    PropsRepository.new
  end
end
