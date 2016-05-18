class Reaction
  pattr_initialize :reaction, :ts, :user_profile

  def upvote
    vote Props::Upvote
  end

  def undo_upvote
    vote Props::UndoUpvote
  end

  def propser
    users_repository.user_from_slack(user_profile)
  end

  def prop
    props_repository.find_by_slack_ts(ts)
  end

  private

  def thumbs_up?
    reaction.include?('+1')
  end

  def vote(voting_service)
    return unless thumbs_up? && prop.present?

    voting_service.new(
      prop: prop,
      user: propser,
      upvotes_repository: upvotes_repository,
    ).call
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
