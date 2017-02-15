require 'rails_helper'

describe SessionsServices::Authorizer do
  describe '#initialize' do
    let(:user) do
      {
        'provider' => SecureRandom.hex,
        'uid' => SecureRandom.hex,
      }
    end

    let(:uid) { user['provider'] + '|' + user['uid'] }
    subject { described_class.new(user) }

    it 'checks proper user setting' do
      expect(subject.user).to be(user)
      expect(subject.uid).to eq(uid)
    end
  end

  describe '#call' do

  end
end
