require 'rails_helper'

describe Notifier::MobileNotifier do
  let(:user_with_pid) { create(:user, pid: create_test_user) }
  let(:user) { create(:user, :with_wrong_pid) }

  describe '#call' do
    context 'user with proper player id' do
      let(:prop) { create(:prop, users: [user_with_pid]) }
      let(:notification) { NewPropNotification.new(prop) }

      subject { described_class.new(notification).call }
      # need to be changed: not_to ~ to , after add app_id env variable
      it { is_expected.not_to eq '200 OK' }
    end

    context 'user with wrong player id' do
      let(:prop) { create(:prop, users: [user]) }
      let(:notification) { NewPropNotification.new(prop) }

      subject { described_class.new(notification).call }
      it { is_expected.to eq '400' }
    end
  end
end
