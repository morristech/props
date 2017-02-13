require 'rails_helper'

describe Notifier::MobileNotifier do
  # need to be changed after add app_id env variable
  # let(:user_with_pid) { create(:user, pid: create_test_user) }
  let(:user) { create(:user, :with_wrong_pid) }

  describe '#initialize' do
    let(:notifier) { double }
    subject { described_class.new(notifier) }

    let(:onesignal_api_key) { double }
    let(:onesignal_user_auth_key) { double }

    before do
      allow(Dotenv).to receive(:load).once
      allow(ENV).to receive(:[]).with('ONESIGNAL_API_KEY').and_return(onesignal_api_key)
      allow(ENV).to receive(:[]).with('ONESIGNAL_USER_AUTH_KEY').and_return(onesignal_user_auth_key)
    end

    it '' do
      expect(Dotenv).to receive(:load).with(no_args).once.ordered
      expect(OneSignal::OneSignal).to receive(:api_key=).with(onesignal_api_key).once.ordered
      expect(OneSignal::OneSignal).to receive(:user_auth_key=).with(onesignal_user_auth_key)
                                                              .once.ordered
      subject
    end
  end

  # describe '#notify' do
  #   # context 'user with proper player id' do
  #   #   let(:prop) { create(:prop, users: [user_with_pid]) }
  #   #   let(:notification) { NewPropNotification.new(prop) }

  #   #   subject { described_class.new(notification).call }
  #   #   it { is_expected.to eq '200 OK' }
  #   # end

  #   context 'user with wrong player id' do
  #     let(:prop) { create(:prop, users: [user]) }
  #     let(:notification) { NewPropNotification.new(prop) }

  #     subject { described_class.new(notification).call }
  #     it { is_expected.to eq '400' }
  #   end
  # end

  # describe '#send_notification' do

  # end
end
