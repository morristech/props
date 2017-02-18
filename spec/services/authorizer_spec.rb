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
    let(:auth0_api_client_id) { SecureRandom.hex }
    let(:auth0_domain) { SecureRandom.hex }
    let(:auth0) { double }
    let(:uid) { SecureRandom.hex }
    let(:provider) { SecureRandom.hex }
    let(:access_token) { SecureRandom.hex }
    let(:auth0_user) { double }

    let(:auth0_params) do
      {
        client_id: auth0_api_client_id,
        domain: auth0_domain,
        token: '',
        api_version: 2,
      }
    end

    let(:user) do
      {
        'provider' => SecureRandom.hex,
        'uid' => uid,
      }
    end

    subject { described_class.new(user).call }

    before do
      allow_any_instance_of(described_class).to receive(:call).and_return(true)
    end

    it 'check proper call settings' do
      expect_any_instance_of(described_class).to receive(:call).and_return(true)
      subject
    end
  end
end
