module Props
  class UndoUpvote
    pattr_initialize [:prop!, :user!, :upvotes_repository!]

    def call
      upvote = upvote_repository.remove(prop, user)
      if upvote.destroyed?
        Response::Success.new(data: prop.reload)
      else
        Response::Error.new(errors: upvote.errors)
    end
  end
end
