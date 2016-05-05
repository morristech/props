class UpvotesRepository
  def add(prop, user)
    Upvote.create(prop_id: prop.id, user_id: user.id)
  end

  def remove(prop, user)
    upvote = Upvote.find_by(prop_id: prop.id, user_id: user.id)
    upvote.destroy unless upvote.nil?
  end
end
