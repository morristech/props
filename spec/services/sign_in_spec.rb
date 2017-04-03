require 'rails_helper'

describe Users::SignIn do
  describe '#call' do
    it 'returns object with user_id and organisation_id' do
      auth = create_auth
      sign_in = Users::SignIn.new(auth: auth)

      result = sign_in.call

      expect(result.membership.user_id).to eq(User.first.id)
      expect(result.membership.organisation_id).to eq(Organisation.first.id)
    end

    it 'adds user to the organisation' do
      auth = create_auth
      sign_in = Users::SignIn.new(auth: auth)

      sign_in.call

      expect(Organisation.first.users).to include(User.first)
    end

    def create_auth
      {
        'provider' => 'slack',
        'uid' => 'auth_uid',
        'info' => { 'nickname' => 'tod', 'email' => 'aaa@bbb.cc' },
      }
    end
  end
end
