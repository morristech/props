class VotingJob < ActiveJob::Base
  queue_as :default

  EVENTS = {
    'reaction_added' => :upvote,
    'reaction_removed' => :undo_upvote,
  }.freeze

  def perform(type, item_ts, uuid, event)
    Reaction.new(type, item_ts, uuid).public_send(EVENTS[event])
  end
end
