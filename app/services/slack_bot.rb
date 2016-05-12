class SlackBot
  def initialize
    @client = Slack::RealTime::Client.new
    set_lifecycle_listeners
  end

  def listen
    @client.start_async
  end

  private

  def hello
    puts "Connected to '#{@client.team.name}' team at https://#{@client.team.domain}.slack.com."
  end

  def close
    puts "SlackBot is about to disconnect"
  end

  def closed
    puts "SlackBot has disconnected successfully!"
  end

  def set_lifecycle_listeners
    %i(hello close closed).each do |event|
      @client.on(event) { send(event) }
    end
  end
end
