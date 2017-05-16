require 'rails_helper'

describe Api::V1::SlackCommands do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user, uid: 'U5DH4MX6F') }
  let!(:user_3) { create(:user, uid: '4MX6FU5DH') }
  let!(:organisation) { create(:organisation) }
  let(:path) { '/api/v1/slack_commands/kudos' }

  describe 'POST /api/v1/slack_commands/kudos' do
    context 'token is valid' do
      let!(:api_token) { EasyTokens::Token.create(value: 'aaabbbccc', owner_id: user_1.id) }

      context 'when params are valid' do
        let(:params) do
          {
            token: 'aaabbbccc',
            team_id: organisation.team_id,
            user_id: user_1.uid,
            command: '/props',
            text: 'some message here <@U5DH4MX6F|hubert>',
          }
        end
        let(:message) do
          "{\"text\":\"#{I18n.t('slack_commands.kudos.messages.created')}\"}"
        end

        subject { post path, params }

        it 'creates prop' do
          expect { subject }.to change { Prop.count }.from(0).to(1)
        end

        it 'sets prop receivers' do
          subject
          expect(Prop.last.prop_receivers.count).to eq 1
        end

        it 'removes users from message' do
          subject
          expect(Prop.last.body).to eq 'some message here'
        end

        it 'returns message' do
          subject
          expect(response.body).to eq message
        end
      end

      context 'when there are 2 prop receivers' do
        let(:params) do
          {
            token: 'aaabbbccc',
            team_id: organisation.team_id,
            user_id: user_1.uid,
            command: '/props',
            text: 'some message here <@U5DH4MX6F|susan> <@4MX6FU5DH|john>',
          }
        end
        let(:message) do
          "{\"text\":\"#{I18n.t('slack_commands.kudos.messages.created')}\"}"
        end

        subject { post path, params }

        it 'creates prop' do
          expect { subject }.to change { Prop.count }.from(0).to(1)
        end

        it 'sets prop receivers' do
          subject
          expect(Prop.last.prop_receivers.count).to eq 2
        end

        it 'returns message' do
          subject
          expect(response.body).to eq message
        end
      end

      context 'when prop receiver is missing' do
        let(:params) do
          {
            token: 'aaabbbccc',
            team_id: organisation.team_id,
            user_id: user_1.uid,
            command: '/props',
            text: 'some message here',
          }
        end
        let(:message) do
          "{\"text\":\"#{I18n.t('slack_commands.kudos.errors.prop_receivers_missing')}\"}"
        end

        subject { post path, params }

        it 'does not create prop' do
          expect { subject }.not_to change { Prop.count }
        end

        it 'returns message' do
          subject
          expect(response.body).to eq message
        end
      end

      context 'when params are not valid' do
        let(:params) do
          {
            token: 'aaabbbccc',
            team_id: '',
            user_id: '',
            command: '',
            text: 'some message here <@U5DH4MX6F|susan>',
          }
        end
        let(:message) do
          "{\"text\":\"#{I18n.t('slack_commands.kudos.errors.params_missing')}\"}"
        end

        subject { post path, params }

        it 'does not create prop' do
          expect { subject }.not_to change { Prop.count }
        end

        it 'returns message' do
          subject
          expect(response.body).to eq message
        end
      end

      context 'when mentioned user is not present in database' do
        let(:params) do
          {
            token: 'aaabbbccc',
            team_id: organisation.team_id,
            user_id: user_1.uid,
            command: '/props',
            text: 'some message here <@SL832DXD|terry>',
          }
        end
        let(:message) do
          "{\"text\":\"#{I18n.t('slack_commands.kudos.errors.prop_receivers_missing')}\"}"
        end

        subject { post path, params }

        it 'does not create prop' do
          expect { subject }.not_to change { Prop.count }
        end

        it 'returns message' do
          subject
          expect(response.body).to eq message
        end
      end

      context 'when one user is mentioned twice' do
        let(:params) do
          {
            token: 'aaabbbccc',
            team_id: organisation.team_id,
            user_id: user_1.uid,
            command: '/props',
            text: 'some message here <@U5DH4MX6F|hubert> <@U5DH4MX6F|hubert>',
          }
        end
        let(:message) do
          "{\"text\":\"#{I18n.t('slack_commands.kudos.messages.created')}\"}"
        end

        subject { post path, params }

        it 'creates prop' do
          expect { subject }.to change { Prop.count }.from(0).to(1)
        end

        it 'sets prop receivers' do
          subject
          expect(Prop.last.prop_receivers.count).to eq 1
        end

        it 'removes users from message' do
          subject
          expect(Prop.last.body).to eq 'some message here'
        end

        it 'returns message' do
          subject
          expect(response.body).to eq message
        end
      end
    end

    context 'token is invalid' do
      it 'returns unathorized response' do
        post path
        expect(response).to have_http_status(401)
      end
    end
  end
end
