require 'rails_helper'

include OmniauthHelpers

describe Users::CreateFromSlackFetch do
  describe '#call' do
    let(:user_info) { users_list_array.first }

    subject { described_class.new(user_info: user_info).call }

    context 'when there is a new user in Slack organisation' do
      it 'creates new user with proper attributes', :aggregate_failures do
        expect { subject }.to change(User, :count).by(1)
        user = User.last
        expect(user.provider).to eq('slack')
        expect(user.uid).to eq(user_info['id'])
        expect(user.name).to eq(user_info['real_name'])
        expect(user.email).to eq(user_info['profile']['email'])
        expect(user.admin).to eq(user_info['is_admin'])
        expect(user.avatar).to eq(user_info['profile']['image_512'])
      end
    end

    context 'when user was already in the database', :freeze_time do
      let(:uid) { user_info['id'] }

      context 'when user uid is matching' do
        let!(:user) { create(:user, uid: uid, name: 'Old Name') }

        it 'updates user data' do
          subject
          expect(user.reload.name).to eq(user_info['real_name'])
        end

        it 'does not create new user' do
          expect { subject }.not_to change(User, :count)
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
          expect { subject }.not_to change(User, :count)
        end
      end

      context 'when user is deleted from Slack organisation' do
        let!(:user) { create(:user, uid: uid) }

        before do
          user_info['deleted'] = true
        end

        it 'archives user', :aggregate_failures do
          expect(user.archived_at?).to eq(false)
          subject
          user.reload
          expect(user.archived_at?).to eq(true)
          expect(user.archived_at.to_s).to eq(Time.current.to_s)
        end

        it 'does not create new user' do
          expect { subject }.not_to change(User, :count)
        end
      end

      context 'when user was deleted from Slack organisation, but is no longer' do
        let!(:user) { create(:user, uid: uid, archived_at: Time.current) }

        it 'unarchives user' do
          subject
          expect(user.reload.archived_at?).to eq(false)
        end

        it 'does not create new user' do
          expect { subject }.not_to change(User, :count)
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
      it 'assigns blank string in place of real name' do
        user_info['profile']['email'] = nil
        subject
        expect(User.last.email).to eq('')
      end
    end

    context 'when there is no info in Slack response about admins status' do
      it 'assigns false' do
        user_info['is_admin'] = nil
        subject
        expect(User.last.admin).to eq(false)
      end
    end
  end
end
