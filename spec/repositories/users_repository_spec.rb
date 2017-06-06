require 'rails_helper'
include OmniauthHelpers

describe UsersRepository do
  let(:user) { create(:user, name: 'John Doe', email: 'user@example.com') }
  let(:archived_user) { create(:user, archived_at: Time.now) }
  let(:repo) { described_class.new }

  describe '#find_by_id' do
    it 'returns active user' do
      expect(repo.find_by_id(user.id)).to eq(user)
    end

    it 'returns archived users' do
      expect(repo.find_by_id(archived_user.id)).to eq(archived_user)
    end
  end

  describe '#user_from_auth' do
    let(:new_email) { 'different@email.com' }
    let(:new_avatar) { 'slack.com/new_avatar.png' }
    let(:auth) { create_auth(email: new_email, avatar: new_avatar) }

    subject { repo.user_from_auth(auth) }

    it 'returns user object' do
      expect(subject).to eq(User.first)
    end

    context 'when user is already in the database' do
      let!(:user_with_uid) { create(:user, uid: auth['uid']) }

      it "updates user's email when it's different from one in the database" do
        subject
        expect(user_with_uid.reload.email).to eq(new_email)
      end

      it "updates user's avatar when it's different from one in the database" do
        subject
        expect(user_with_uid.reload.avatar).to eq(new_avatar)
      end
    end

    context 'when auth is_admin is true' do
      let(:auth) { create_auth(is_admin: true) }

      it 'saves user as admin' do
        subject
        expect(User.first.admin).to eq true
      end
    end

    context 'when auth is_admin is false' do
      let(:auth) { create_auth(is_admin: false) }

      it 'does not save user as admin' do
        subject
        expect(User.first.admin).to eq false
      end
    end
  end

  describe '#user_from_slack' do
    let(:slack_member) do
      {
        'profile' => {
          'email' => email,
          'real_name' => name,
        },
      }
    end

    before do
      AppConfig.stub(:[]).with('domain_name').and_return('example.com')
      AppConfig.stub(:[]).with('extra_domains').and_return('example.co')
      user.reload
    end

    context 'email recieved from slack is matching' do
      let(:email) { 'user@example.com' }
      let(:name) { 'John F Kennedy' }

      it 'returns correct user' do
        expect(repo.user_from_slack(slack_member)).to eq(user)
      end
    end

    context 'local part of email is matching and domain is allowed by extra_domains' do
      let(:email) { 'user@example.co' }
      let(:name) { 'John F Kennedy' }

      it 'returns correct user' do
        expect(repo.user_from_slack(slack_member)).to eq(user)
      end
    end

    context 'email is not reconized' do
      let(:email) { 'wrong@email.co' }

      context 'name is matching' do
        let(:name) { 'John Doe' }

        it 'returns correct user' do
          expect(repo.user_from_slack(slack_member)).to eq(user)
        end
      end

      context 'name is not matching' do
        let(:name) { 'John F Kennedy' }

        subject { repo.user_from_slack(slack_member) }

        it { expect { subject }.to change(User, :count).by(1) }
        it { expect(subject).to eq(User.last) }
        it { expect(subject.email).to eq(email) }
        it { expect(subject.name).to eq(name) }
      end
    end
  end
end
