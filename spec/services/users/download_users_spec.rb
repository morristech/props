require 'rails_helper'

include OmniauthHelpers

describe Users::DownloadUsers do
  describe '#call' do
    let(:organisation) { create(:organisation) }
    let(:users_list) { double('users_list', members: members) }

    subject { described_class.new(organisation: organisation).call }

    before do
      allow_any_instance_of(Slack::RealTime::Client).to receive_message_chain(:web_client, :users_list) { users_list }
    end

    context 'when there is new user in Slack organisation' do
      let(:members) { users_list_array(users_number: 1) }

      it 'creates new user' do
        expect { subject }.to change { User.count }.by(1)
      end

      it 'creates new user with proper attributes' do
        subject
        expect(User.last.uid).to eq(members.last['id'])
      end

      it 'adds user to organisation' do
        expect { subject }.to change { organisation.users.count }.by(1)
      end
    end

    context 'when there are few new users in the Slack organisation' do
      let(:members) { users_list_array(users_number: 3) }

      it 'creates few new users' do
        expect { subject }.to change { User.count }.by(3)
      end

      it 'creates new user with proper attributes', :aggregate_failures do
        subject
        expect(User.first.uid).to eq(members.first['id'])
        expect(User.last.uid).to eq(members.last['id'])
      end

      it 'adds users to organisation' do
        expect { subject }.to change { organisation.users.count }.by(3)
      end
    end

    context 'when an user is a bot' do
      let(:members) { users_list_array(users_number: 2, is_bot: true) }

      it 'does not create a new user' do
        expect { subject }.not_to change { User.count }
      end

      it 'omits only bot users and creates normal user' do
        members.second['is_bot'] = false
        expect { subject }.to change { User.count }.by(1)
      end

      it 'does not add user to organisation' do
        expect { subject }.not_to change { organisation.users.count }
      end
    end

    context 'when an user has "slackbot" name' do
      let(:members) { users_list_array(users_number: 2) }

      before do
        members.first['name'] = 'slackbot'
      end

      it 'does not create a new user' do
        members.second['name'] = 'slackbot'
        expect { subject }.not_to change { User.count }
      end

      it 'omits only bot users and creates normal user' do
        expect { subject }.to change { User.count }.by(1)
      end
    end

    context 'when user was already in the database' do
      let(:members) { users_list_array(users_number: 1) }
      let(:uid) { members.first['id'] }
      let(:email) { members.first['profile']['email'] }
      let(:user) do
        create(:user, uid: uid, email: email, name: 'Old Name')
      end
      let(:organisation) { create(:organisation, users: [user]) }

      it 'updates user data', :aggregate_failures do
        expect(organisation.users.last.name).to eq(user.name)
        subject
        expect(user.reload.name).to eq(members.first['real_name'])
      end
    end
  end
end
