class SlackBot
  attr_private :client

  def initialize
    @client = Slack::RealTime::Client.new
    set_lifecycle_listeners
    set_reaction_listeners
  end

  def listen
    client.start_async
  end

  private

  def reaction(data)
    Reaction.new data[:reaction],
                 data[:item][:ts],
                 user_profile(data[:user])
  end

  def reaction_added(data)
    reaction(data).upvote
  end

  def reaction_removed(data)
    reaction(data).undo_upvote
  end

  def hello
    puts "Connected to '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
  end

  def close
    puts 'SlackBot is about to disconnect'
  end

  def closed
    puts 'SlackBot has disconnected successfully!'
  end

  def set_reaction_listeners
    %i(reaction_added reaction_removed).each do |event|
      client.on(event) { |data| send(event, data) }
    end
  end

  def set_lifecycle_listeners
    %i(hello close closed).each do |event|
      client.on(event) { send(event) }
    end
  end

  def user_profile(id)
    client.web_client.users_list[:members].detect { |member| member[:id] == id }
  end
end
