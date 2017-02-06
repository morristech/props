require 'rails_helper'

describe Notifier::MobileNotifier do
  # Dotenv.load
  # OneSignal::OneSignal.api_key = ENV['ONESIGNAL_API_KEY']
  # OneSignal::OneSignal.user_auth_key = ENV['ONESIGNAL_USER_AUTH_KEY']
  # let(:app_id) { ENV['APP_ID'] }

  # let(:params) do
  #   {
  #     app_id: app_id,
  #     device_type: 1,
  #   }
  # end

  let(:prop) { create(:prop) }
  let(:notification) { NewPropNotification.new(prop) }

  subject { described_class.new(notification) }

  describe '#call' do
    context 'user with proper player id' do
      it 'return 200' do

      end
    end
  end
end
