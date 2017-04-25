require 'rails_helper'

describe Api::V1::Users do
  let!(:users) { create_list(:user, 2) }
  let(:membership) { create(:membership, user: users[0]) }

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
        expect(json_response.size).to eq(
          UsersRepository.new.for_organisation(membership.organisation).count,
        )
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
      it 'returns specific user' do
        membership = create :membership
        user = create(:user)
        membership.organisation.users << user
        sign_in(membership)

        get "/api/v1/users/#{user.id}"

        expect(json_response['name']).to eq user.name

        sign_out
      end

      it 'returns forbidden status when accessing user in different organisation' do
        sign_in(create(:membership))
        user_in_different_organisation = create :user
        organisation_b = create :organisation
        organisation_b.users << user_in_different_organisation

        get "/api/v1/users/#{user_in_different_organisation.id}"

        expect(response).to have_http_status(403)

        sign_out
      end
    end
  end
end
