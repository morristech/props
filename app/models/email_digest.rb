class EmailDigest
  attr_accessor :since_timestamp, :user, :props_repo

  def initialize(since_timestamp:, user:, props_repo: PropsRepository.new)
    @since_timestamp = since_timestamp
    @user = user
    @props_repo = props_repo
  end

  def props_received
    props_repo.search(user_id: user.id, after: since_timestamp).results.to_a
  end
end
