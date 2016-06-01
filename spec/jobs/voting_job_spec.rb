require 'rails_helper'

RSpec.describe VotingJob, type: :job do
  include ActiveJob::TestHelper

  let!(:prop) { create(:prop, slack_ts: '123.321') }
  let!(:user) { create(:user, email: 'john@doe.com') }

  let(:ts) { '123.321' }
  let(:uuid) { '123' }
  let(:reaction_symbol) { ':+1:' }

  subject { described_class.perform_later(reaction_symbol, ts, uuid, type) }

  before do
    allow_any_instance_of(Reaction).to receive(:user_profile) do
      { 'profile' => { 'email' => 'john@doe.com' } }
    end
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end

  context 'reaction added' do
    let(:type) { 'reaction_added' }

    it 'adds job to queue' do
      expect { subject }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by 1
    end

    context 'reaction is +1' do
      it 'creates new upvote' do
        perform_enqueued_jobs do
          expect { subject }.to change(Upvote, :count).by 1
        end
      end

      context 'prop already upvoted by user' do
        let!(:upvote) { create(:upvote, user: user, prop: prop) }

        it 'does not create new upvote' do
          perform_enqueued_jobs do
            expect { subject }.to_not change(Upvote, :count)
          end
        end
      end
    end

    context 'reaction is not +1' do
      let(:reaction_symbol) { ':smile:' }

      it 'does not create new upvote' do
        perform_enqueued_jobs do
          expect { subject }.to_not change(Upvote, :count)
        end
      end
    end

    context 'ts does not match prop' do
      let(:ts) { 'wrong_ts' }

      it 'does not create new upvote' do
        perform_enqueued_jobs do
          expect { subject }.to_not change(Upvote, :count)
        end
      end
    end
  end

  context 'reaction removed' do
    let(:type) { 'reaction_removed' }

    it 'adds job to queue' do
      expect { subject }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by 1
    end

    context 'upvote exist' do
      let!(:upvote) { create(:upvote, user: user, prop: prop) }

      context 'reaction is +1' do
        it 'removes upvote' do
          perform_enqueued_jobs do
            expect { subject }.to change(Upvote, :count).by(-1)
          end
        end
      end

      context 'reaction is not +1' do
        let(:reaction_symbol) { ':smile:' }

        it 'does not remove upvote' do
          perform_enqueued_jobs do
            expect { subject }.to_not change(Upvote, :count)
          end
        end
      end

      context 'ts does not match prop' do
        let(:ts) { 'wrong_ts' }

        it 'does not remove upvote' do
          perform_enqueued_jobs do
            expect { subject }.to_not change(Upvote, :count)
          end
        end
      end
    end

    context 'upvote to undo does not exist' do
      it 'does not remove upvote' do
        perform_enqueued_jobs do
          expect { subject }.to_not change(Upvote, :count)
        end
      end
    end
  end
end
