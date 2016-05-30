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
      client.on(event) do |data|
        VotingJob.perform_later data[:reaction],
                                data[:item][:ts],
                                data[:user],
                                data[:type]
      end
    end
  end

  def set_lifecycle_listeners
    %i(hello close closed).each do |event|
      client.on(event) { send(event) }
    end
  end
end
