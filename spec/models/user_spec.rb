require 'rails_helper'

include OmniauthHelpers

describe User do
  describe 'associations' do
    it { is_expected.to have_many(:memberships) }
    it { is_expected.to have_many(:organisations).through(:memberships) }
  end

  describe '.create_with_slack_fetch' do
    let(:user_info) { users_list_array.first }
    let(:organisation) { create(:organisation) }

    subject { described_class.create_with_slack_fetch(user_info) }

    context 'when there is a new user in Slack organisation' do
      it 'creates new user' do
        expect { subject }.to change { User.count }.by(1)
      end

      it 'creates new user with proper attributes', :aggregate_failures do
        subject
        expect(User.last.provider).to eq('slack')
        expect(User.last.uid).to eq(user_info['id'])
        expect(User.last.name).to eq(user_info['real_name'])
        expect(User.last.email).to eq(user_info['profile']['email'])
        expect(User.last.admin).to eq(user_info['is_admin'])
        expect(User.last.avatar).to eq(user_info['profile']['image_512'])
      end
    end

    context 'when user was already in the database' do
      context 'when user uid is matching' do
        let!(:user) { create(:user, uid: uid, name: 'Old Name') }
        let(:uid) { user_info['id'] }

        it 'updates user data' do
          subject
          expect(user.reload.name).to eq(user_info['real_name'])
        end

        it 'does not create new user' do
          expect { subject }.not_to change { User.count }
        end
      end

      context 'when user email is matching' do
        let!(:user) { create(:user, email: email, name: 'Old Name') }
        let(:email) { user_info['profile']['email'] }

        it 'updates user data' do
          subject
          expect(user.reload.name).to eq(user_info['real_name'])
        end

        it 'does not create new user' do
          expect { subject }.not_to change { User.count }
        end
      end
    end

    context 'when real_name in Slack response is blank' do
      it 'uses mention in place of real name' do
        user_info['real_name'] = ''
        subject
        expect(User.last.name).to eq(user_info['name'])
      end
    end

    context 'when email in Slack response is nil' do
      it 'asigns blank string in place of real name' do
        user_info['profile']['email'] = nil
        subject
        expect(User.last.email).to eq('')
      end
    end

    context 'when there is no info in Slack response about admins status' do
      it 'asigns false' do
        user_info['is_admin'] = nil
        subject
        expect(User.last.admin).to eq(false)
      end
    end
  end
end
