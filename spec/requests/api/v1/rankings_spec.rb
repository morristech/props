require 'rails_helper'

describe Api::V1::Rankings do
  let(:propser) { create(:user) }
  let(:receiver) { create(:user) }
  let(:organisation) { create(:organisation) }
  let(:prop_receiver) { PropReceiver.create(user: receiver) }
  let!(:prop) do
    Prop.create(body: 'sample', propser: propser,
                prop_receivers: [prop_receiver],
                organisation: organisation)
  end
  let!(:api_token) { EasyTokens::Token.create(value: 'aaabbbccc', owner_id: propser.id) }

  describe 'GET /api/v1/rankings/hero_of_the_week' do
    before do
      get '/api/v1/rankings/hero_of_the_week', token: token
    end

    context 'with invalid api token' do
      let(:token) { 'cccbbbaaa' }

      it "returns 'Invalid token' response" do
        result = json_response['error']
        expect(result).to eq 'Invalid token'
      end
    end

    context 'with valid api token' do
      let(:token) { api_token.value }

      it 'returns user with the most received props' do
        expect(json_response['user']).to eq receiver.name
        expect(json_response['kudos_count']).to eq 1
      end
    end
  end
end
