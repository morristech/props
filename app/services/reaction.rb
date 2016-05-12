class Reaction
  pattr_initialize :reaction, :ts, :user_profile

  def propser
    users_repository.user_from_slack(user_profile)
  end

  def thumbs_up?
    reaction.include?('+1')
  end

  def prop
    props_repository.find_by_slack_ts(ts)
  end

  def upvote
    vote Props::Upvote
  end

  def undo_upvote
    vote Props::UndoUpvote
  end

  def vote(service)
    return unless thumbs_up? && prop.present?
    service.new(vote_attributes).call
  end

  private

  def vote_attributes
    {
      prop: prop,
      user: propser,
      upvotes_repository: upvotes_repository,
    }
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
