class Notifier
  class MobileNotifier < Base
    private


    def create_player(uid)
      Dotenv.load
      api_key = ENV['ONESIGNAL_API_KEY']
      user_auth_key = ENV['ONESIGNAL_USER_AUTH_KEY']
      app_id = ENV['APP_ID']

      params = {
        app_id: app_id,
        device_type: 0,
        identifier: uid,
      }

      response = OneSignal::Player.create(params: params)
    end

    def notify
      Dotenv.load
      api_key = ENV['ONESIGNAL_API_KEY']
      user_auth_key = ENV['ONESIGNAL_USER_AUTH_KEY']
      app_id = ENV['APP_ID']

      # configure OneSignal
      OneSignal::OneSignal.api_key = api_key
      OneSignal::OneSignal.user_auth_key = user_auth_key

      # hardcoded id of my device
      player_id = '381d995b-ecef-4682-a6a3-95bb95890825'

      # notify
      params = {
        app_id: app_id,
        contents: {
          en: "#{notification.body}"
        },
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
      # end
    end
  end
end
