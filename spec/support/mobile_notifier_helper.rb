module MobileNotifierHelper
  def create_test_user(id = 123)
    Dotenv.load
    OneSignal::OneSignal.api_key = ENV['ONESIGNAL_API_KEY']
    OneSignal::OneSignal.user_auth_key = ENV['ONESIGNAL_USER_AUTH_KEY']
    app_id = ENV['APP_ID']
    params = {
      app_id: app_id,
      device_type: 1,
      identifier: id.to_s,
      tags: {
        test_user: 'true',
      },
    }
    response = OneSignal::Player.create(params: params)
    JSON.parse(response.body)['id']
  end
end
