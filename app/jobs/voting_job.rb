class VotingJob < ActiveJob::Base
  queue_as :default

  TYPES = {
    'reaction_added' => :upvote,
    'reaction_removed' => :undo_upvote,
  }.freeze

  def perform(reaction, ts, uid, type)
    return unless thumbs_up?(reaction)
    Reaction.new(reaction, ts, uid).public_send(TYPES[type])
  end

  private

  def thumbs_up?(reaction)
    reaction.include?('+1')
  end
end
