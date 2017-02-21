require 'rails_helper'

describe Notifier::MobileNotifier do
  let(:notification) { double }

  describe '#initialize' do
    subject { described_class.new(notification) }

    let(:onesignal_api_key) { double }
    let(:onesignal_user_auth_key) { double }

    before do
      allow(Dotenv).to receive(:load).once
      allow(ENV).to receive(:[]).with('ONESIGNAL_API_KEY').and_return(onesignal_api_key)
      allow(ENV).to receive(:[]).with('ONESIGNAL_USER_AUTH_KEY').and_return(onesignal_user_auth_key)
    end

    it 'assigns enviroment variables setting' do
      expect(Dotenv).to receive(:load).with(no_args).once.ordered
      expect(OneSignal::OneSignal).to receive(:api_key=).with(onesignal_api_key).once.ordered
      expect(OneSignal::OneSignal).to receive(:user_auth_key=).with(onesignal_user_auth_key)
        .once.ordered
      subject
    end

    it 'assigns proper notification setting' do
      expect(subject.notification).to be(notification)
    end
  end

  describe '#notify' do
    let(:params) { double }
    subject { described_class.new(notification) }

    before do
      allow(notification).to receive_message_chain(:prop, :users, :pluck).and_return(double)
      allow(notification).to receive(:mobile_body).and_return(double)
    end

    it 'returns send_notification method once' do
      expect(subject).to receive(:send_notification).once
      subject.notify
    end
  end

  describe '#send_notification' do
    context 'OneSignal::OneSignalError is not thrown' do
      let(:params) { double }
      let(:returned_value) { double }
      let(:response) do
        {
          'status' => returned_value,
        }
      end

      subject { described_class.new(notification).send_notification(params) }

      before do
        allow(OneSignal::Notification).to receive(:create).and_return(response)
      end

      include_examples 'OneSignal::Notification.create called once'

      it 'returns proper value' do
        expect(subject).to eq returned_value
      end
    end

    context 'OneSignal::OneSignalError is thrown' do
      let(:exception) { OneSignal::OneSignalError }
      let(:params) { double }

      subject { described_class.new(notification).send_notification(params) }

      before do
        allow(OneSignal::Notification).to receive(:create).and_raise(exception)
      end

      include_examples'OneSignal::Notification.create called once'

      it 'raises exception' do
        expect(subject).to be_nil
      end
    end
  end
end
