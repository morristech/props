require 'rails_helper'

describe SessionsServices::Authorizer do
  let(:user) do
    {
      'provider' => SecureRandom.hex,
      'uid' => SecureRandom.hex,
    }
  end

  describe '#initialize' do
    let(:uid) { user['provider'] + '|' + user['uid'] }
    subject { described_class.new(user) }

    it 'checks proper user setting' do
      expect(subject.user).to be(user)
      expect(subject.uid).to eq(uid)
    end
  end

  describe '#call' do
    let(:auth_params) { double }
    let(:auth0) { double }

    subject { described_class.new(user).call }

    before do
      allow(auth_params).to receive(:[]).with(:token)
      allow(Auth0Client).to receive(:new).and_return(auth0)
      allow(auth0).to receive(:obtain_access_token)
      allow(auth0).to receive(:user).and_return(user)
    end

    context 'user with proper credentials' do
      it 'returns true' do
        allow_any_instance_of(described_class).to receive(:user_authorized?).and_return(true)
        expect_any_instance_of(described_class).to receive(:user_authorized?).and_return(true)
        subject
      end
    end

    context 'user with wrong credentials' do
      it 'returns false' do
        allow_any_instance_of(described_class).to receive(:user_authorized?).and_return(false)
        expect_any_instance_of(described_class).to receive(:user_authorized?).and_return(false)
        subject
      end
    end
  end
end
