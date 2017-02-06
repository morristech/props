class Notifier
  class MobileNotifier < Base
    def create_user
      # Dotenv.load
      # # configure OneSignal
      # OneSignal::OneSignal.api_key = ENV['ONESIGNAL_API_KEY']
      # OneSignal::OneSignal.user_auth_key = ENV['ONESIGNAL_USER_AUTH_KEY']

      # app_id = ENV['APP_ID']

      # device_token = 'abcdabcdabc'
      # params = {
      #   app_id: app_id,
      #   device_type: 0,
      #   identifier: device_token,
      # }

      # response = OneSignal::Player.create(params: params)
      # player_id = JSON.parse(response.body)["id"]
    end

    def notify
      Dotenv.load
      OneSignal::OneSignal.api_key = ENV['ONESIGNAL_API_KEY']
      OneSignal::OneSignal.user_auth_key = ENV['ONESIGNAL_USER_AUTH_KEY']
      app_id = ENV['APP_ID']
      player_ids = notification.prop.users.pluck(:pid)
      # notify
      params = {
        app_id: app_id,
        include_player_ids: player_ids,
        contents: {
          en: notification.body,
        },
      }
      begin
        response = OneSignal::Notification.create(params: params)
        JSON.parse(response.body)['id']
      rescue OneSignal::OneSignalError => e
        puts '--- OneSignalError  :'
        puts "-- message : #{e.message}"
        puts "-- status : #{e.http_status}"
        puts "-- body : #{e.http_body}"
      end
    end
  end
end
