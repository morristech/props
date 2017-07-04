require 'rails_helper'

include OmniauthHelpers

describe Users::CreateFromSlackFetch do
  describe '#call' do
    shared_examples 'assign proper attributes to user' do
      it 'assigns proper attributes to user', :aggregate_failures do
        subject
        user = User.last
        expect(user.provider).to eq('slack')
        expect(user.uid).to eq(user_info['id'])
        expect(user.name).to eq(user_info['real_name'])
        expect(user.email).to eq(user_info['profile']['email'])
        expect(user.admin).to eq(user_info['is_admin'])
        expect(user.avatar).to eq(user_info['profile']['image_512'])
      end
    end

    shared_examples 'call archiver' do
      it 'calls archiver once' do
        allow(Users::ArchiveUser).to receive(:new) { archiver }
        expect(archiver).to receive(:call).once
        subject
      end
    end

    shared_examples 'do not call archiver' do
      it 'does not call archiver' do
        allow(Users::ArchiveUser).to receive(:new) { archiver }
        expect(archiver).not_to receive(:call)
        subject
      end
    end

    shared_examples 'call unarchiver' do
      it 'calls unarchiver once' do
        allow(Users::UnarchiveUser).to receive(:new) { unarchiver }
        expect(unarchiver).to receive(:call).once
        subject
      end
    end

    shared_examples 'do not call unarchiver' do
      it 'does not call unarchiver' do
        allow(Users::UnarchiveUser).to receive(:new) { unarchiver }
        expect(unarchiver).to_not receive(:call)
        subject
      end
    end

    let(:user_info) { users_list_array.first }

    subject { described_class.new(user_info: user_info).call }

    context 'when there is a new user in Slack organisation' do
      include_examples 'assign proper attributes to user'

      it 'creates new user with proper attributes', :aggregate_failures do
        expect { subject }.to change(User, :count).by(1)
      end
    end

    context 'when user has already been in the database', :freeze_time do
      let(:uid) { user_info['id'] }

      context 'when user uid matches' do
        let!(:user) { create(:user, uid: uid, name: 'Old Name') }

        include_examples 'assign proper attributes to user'

        it 'does not create new user' do
          expect { subject }.not_to change(User, :count)
        end
      end

      context 'when user email matches' do
        let!(:user) { create(:user, email: email, name: 'Old Name') }
        let(:email) { user_info['profile']['email'] }

        include_examples 'assign proper attributes to user'

        it 'does not create new user' do
          expect { subject }.not_to change(User, :count)
        end
      end

      context 'when archivisation is processed' do
        let(:archiver) { double }
        let(:unarchiver) { double }

        context 'when user is deleted from Slack organisation but not archived yet' do
          let!(:user) { create(:user, uid: uid) }

          before do
            user_info['deleted'] = true
          end

          include_examples 'assign proper attributes to user'
          include_examples 'call archiver'
          include_examples 'do not call unarchiver'

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

        context 'when user is deleted from Slack organisation and already archived' do
          let!(:user) { create(:user, uid: uid, archived_at: 3.days.ago) }

          before do
            user_info['deleted'] = true
          end

          include_examples 'assign proper attributes to user'
          include_examples 'do not call archiver'
          include_examples 'do not call unarchiver'

          it 'does not change user archive status', :aggregate_failures do
            expect(user.archived_at?).to eq(true)
            subject
            user.reload
            expect(user.archived_at?).to eq(true)
          end

          it 'does not create new user' do
            expect { subject }.not_to change(User, :count)
          end
        end

        context 'when user is not deleted from Slack organisation and is not archived' do
          let!(:user) { create(:user, uid: uid) }

          include_examples 'assign proper attributes to user'
          include_examples 'do not call archiver'
          include_examples 'do not call unarchiver'

          it 'does not change user archive status', :aggregate_failures do
            expect(user.archived_at?).to eq(false)
            subject
            user.reload
            expect(user.archived_at?).to eq(false)
          end

          it 'does not create new user' do
            expect { subject }.not_to change(User, :count)
          end
        end

        context 'when user was deleted from Slack organisation, but is no longer' do
          let!(:user) { create(:user, uid: uid, archived_at: 3.days.ago) }

          include_examples 'assign proper attributes to user'
          include_examples 'do not call archiver'
          include_examples 'call unarchiver'

          it 'unarchives user' do
            subject
            expect(user.reload.archived_at?).to eq(false)
          end

          it 'does not create new user' do
            expect { subject }.not_to change(User, :count)
          end
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
      it 'assigns false to #admin' do
        user_info['is_admin'] = nil
        subject
        expect(User.last.admin).to eq(false)
      end
    end

    context 'when user has smaller avatar' do
      it 'uses "original_image" first' do
        user_info['profile']['image_512'] = nil
        subject
        expect(User.last.avatar).to eq(user_info['profile']['image_original'])
      end

      it 'uses "image_192" when no bigger image is available' do
        user_info['profile']['image_512'] = nil
        user_info['profile']['image_original'] = nil
        subject
        expect(User.last.avatar).to eq(user_info['profile']['image_192'])
      end
    end
  end
end
