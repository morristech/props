require 'rails_helper'

include OmniauthHelpers

describe Users::CreateFromSlackFetch do
  describe '#call' do
    let(:user_info) { users_list_array.first }
    let(:organisation) { create(:organisation) }

    subject { described_class.new.call(user_info) }

    context 'when there is a new user in Slack organisation' do
      it 'creates new user' do
        expect { subject }.to change(User, :count).by(1)
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
      let(:uid) { user_info['id'] }
      let(:time_now) { Time.current }

      context 'when user uid is matching' do
        let!(:user) { create(:user, uid: uid, name: 'Old Name') }
        let(:uid) { user_info['id'] }

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
          expect(user.archived_at.to_s).to eq(time_now.to_s)
        end

        it 'does not create new user' do
          expect { subject }.not_to change(User, :count)
        end
      end

      context 'when user is was deleted from Slack organisation, but is no longer' do
        let!(:user) { create(:user, uid: uid, archived_at: time_now) }

        it 'archives user', :aggregate_failures do
          expect(user.archived_at.to_s).to eq(time_now.to_s)
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
