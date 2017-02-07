require 'rails_helper'

describe Notifier::MobileNotifier do
  let(:good_user) { create(:user, :with_proper_pid) }
  let(:wrong_user) { create(:user, :with_wrong_pid) }

  describe '#call' do
    context 'user with proper player id' do
      let(:prop) { create(:prop, users: [good_user]) }
      let(:notification) { NewPropNotification.new(prop) }

      subject { described_class.new(notification).call }
      it { is_expected.not_to be_nil }
    end

    context 'user with wrong player id' do
      let(:prop) { create(:prop, users: [wrong_user]) }
      let(:notification) { NewPropNotification.new(prop) }

      subject { described_class.new(notification).call }
      it { is_expected.to be_nil }
    end
  end
end
