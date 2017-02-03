require 'one_signal'
require 'dotenv'
class Onesignal

  def notify
    # load your keys with https://github.com/bkeepers/dotenv
    Dotenv.load
    api_key = ENV['ONESIGNAL_API_KEY']
    user_auth_key = ENV['ONESIGNAL_USER_AUTH_KEY']

    # configure OneSignal
    OneSignal::OneSignal.api_key = api_key
    OneSignal::OneSignal.user_auth_key = user_auth_key

    app_id = '3698b50c-d2e9-4c54-8d70-910c0acc1a31'

    # add a player
    device_token = "abcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabcdabc1"

    params = {
      app_id: app_id,
      device_type: 0,
      identifier: device_token,
      tags: {
        user_id: '123'
      }
    }

    player_id = 'b093fe61-26ec-40e3-a803-1cf84dc3e5ae'

    # notify the player (this will fail because we haven't configured the app yet)
    params = {
      app_id: app_id,
      contents: {
        en: 'hello player'
      },
      ios_badgeType: 'None',
      ios_badgeCount: 1,
      include_player_ids: [player_id]
    }
    begin
      response = OneSignal::Notification.create(params: params)
      notification_id = JSON.parse(response.body)["id"]
    rescue OneSignal::OneSignalError => e
      puts "--- OneSignalError  :"
      puts "-- message : #{e.message}"
      puts "-- status : #{e.http_status}"
      puts "-- body : #{e.http_body}"
    end
  end
end
