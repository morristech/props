require 'rails_helper'

describe Notifier::MobileNotifier do
  # need to be changed after add app_id env variable
  # let(:user_with_pid) { create(:user, pid: create_test_user) }
  let(:user) { create(:user, :with_wrong_pid) }

  describe '#call' do
    # context 'user with proper player id' do
    #   let(:prop) { create(:prop, users: [user_with_pid]) }
    #   let(:notification) { NewPropNotification.new(prop) }

    #   subject { described_class.new(notification).call }
    #   it { is_expected.to eq '200 OK' }
    # end

    context 'user with wrong player id' do
      let(:prop) { create(:prop, users: [user]) }
      let(:notification) { NewPropNotification.new(prop) }

      subject { described_class.new(notification).call }
      it { is_expected.to eq '400' }
    end
  end
end
