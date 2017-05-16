require 'rails_helper'

describe Api::V1::Slack do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user, uid: 'U5DH4MX6F') }
  let!(:user_3) { create(:user, uid: '4MX6FU5DH') }
  let!(:organisation) { create(:organisation) }
  let(:path) { '/api/v1/slack/create_prop' }

  describe 'POST /api/v1/slack' do
    context 'token is valid' do
      context 'when params are valid' do
        let(:params) do
          { 
            token: '',
            team_id: organisation.team_id,
            user_id: user_1.uid,
            command: '/props',
            text: 'bla bla bla super ziom <@U5DH4MX6F|hubert>',
          }
        end

        subject { post path, params }

        it 'creates prop' do
          expect { subject }.to change { Prop.count }.from(0).to(1)
        end

        it 'sets 1 prop receivers' do
          subject
          expect(Prop.last.prop_receivers.count).to eq 1
        end

        it 'removes users from message' do
          subject
          expect(Prop.last.body).to eq 'bla bla bla super ziom '
        end

        it 'returns message' do
          subject
          expect(response.body).to eq "{\"text\":\"#{I18n.t('slack.messages.props_created')}\"}"
        end
      end

      context 'when there are 2 props receivers' do
        let(:params) do
          { 
            token: '',
            team_id: organisation.team_id,
            user_id: user_1.uid,
            command: '/props',
            text: 'bla bla bla super ziom <@U5DH4MX6F|susan> <@4MX6FU5DH|john>',
          }
        end

        subject { post path, params }

        it 'creates prop' do
          expect { subject }.to change { Prop.count }.from(0).to(1)
        end

        it 'sets 2 prop receivers' do
          subject
          expect(Prop.last.prop_receivers.count).to eq 2
        end

        it 'returns message' do
          subject
          expect(response.body).to eq "{\"text\":\"#{I18n.t('slack.messages.props_created')}\"}"
        end
      end

      context 'when props receivers is missing' do
        let(:params) do
          { 
            token: '',
            team_id: organisation.team_id,
            user_id: user_1.uid,
            command: '/props',
            text: 'bla bla bla super ziom',
          }
        end

        subject { post path, params }

        it 'does not create prop' do
          expect { subject }.not_to change { Prop.count }
        end

        it 'returns message' do
          subject
          expect(response.body).to eq "{\"text\":\"#{I18n.t('slack.messages.props_not_created')}\"}"
        end
      end
    end

    # context 'token is invalid' do
    #   it 'returns unathorized response' do
    #     post '/api/v1/slack/create_prop'
    #     expect(response).to have_http_status(401)
    #   end
    # end
  end
end
