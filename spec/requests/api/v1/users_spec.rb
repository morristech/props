require 'rails_helper'

describe Api::V1::Users do
  let!(:users) { create_list(:user, 2) }
  let(:membership) { create(:membership, user: users[0]) }
  let!(:inactive_user) { create(:user, archived_at: Time.now) }

  describe 'GET /api/v1/users' do
    include_context 'token accessible api' do
      let(:path) { '/api/v1/users' }
    end

    context 'user is a guest' do
      it 'returns unathorized response' do
        get '/api/v1/users'
        expect(response).to have_http_status(401)
      end
    end

    context 'user is signed in' do
      before do
        sign_in(membership)
        get '/api/v1/users'
      end

      after { sign_out }

      it 'returns all active users for current organisation' do
        expect(json_response.class).to be Array
        expect(json_response.size).to eq UsersRepository.new.for_organisation(membership.organisation).count
      end
    end
  end

  describe 'GET /api/v1/users/:user_id' do
    include_context 'token accessible api' do
      let(:path) { "/api/v1/users/#{user.id}" }
    end

    context 'user is a guest' do
      it 'returns unathorized response' do
        get "/api/v1/users/#{users[0].id}"
        expect(response).to have_http_status(401)
      end
    end

    context 'user is signed in' do
      before do
        sign_in(users[0])
        get "/api/v1/users/#{users[0].id}"
      end

      after { sign_out }

      it 'returns specific user' do
        expect(json_response['name']).to eq users[0].name
      end
    end
  end
end
