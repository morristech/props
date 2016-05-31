require 'rails_helper'

RSpec.describe VotingJob, type: :job do
  include ActiveJob::TestHelper

  let!(:prop) { create(:prop, slack_ts: '123.321') }
  let!(:user) { create(:user, email: 'john@doe.com') }

  let(:reaction_symbol) { ':+1:' }
  let(:ts) { '123.321' }
  let(:uuid) { '123' }
  let(:upvote_service) { double }
  let(:undo_upvote_service) { double }

  subject { described_class.perform_later(reaction_symbol, ts, uuid, type) }

  before do
    allow_any_instance_of(Reaction).to receive(:user_profile) do
      { 'profile' => { 'email' => 'john@doe.com' } }
    end

    allow(Props::Upvote).to receive(:new) { upvote_service }
    allow(Props::UndoUpvote).to receive(:new) { undo_upvote_service }
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

    it 'calls Upvote service' do
      expect(upvote_service).to receive(:call)
      perform_enqueued_jobs { subject }
    end

    context 'reaction is not +1' do
      let(:reaction_symbol) { ':smile:' }

      it 'does not call Upvote service' do
        expect(upvote_service).to_not receive(:call)
        perform_enqueued_jobs { subject }
      end
    end

    context 'ts does not match prop' do
      let(:ts) { 'wrong_ts' }

      it 'does not call Upvote service' do
        expect(upvote_service).to_not receive(:call)
        perform_enqueued_jobs { subject }
      end
    end
  end

  context 'reaction removed' do
    let(:type) { 'reaction_removed' }

    it 'adds job to queue' do
      expect { subject }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by 1
    end

    it 'calls UndoUpvote service' do
      expect(undo_upvote_service).to receive(:call)
      perform_enqueued_jobs { subject }
    end

    context 'reaction is not +1' do
      let(:reaction_symbol) { ':smile:' }

      it 'does not call UndoUpvote service' do
        expect(undo_upvote_service).to_not receive(:call)
        perform_enqueued_jobs { subject }
      end
    end

    context 'reaction is not +1' do
      let(:ts) { 'wrong_ts' }

      it 'does not call UndoUpvote service' do
        expect(undo_upvote_service).to_not receive(:call)
        perform_enqueued_jobs { subject }
      end
    end
  end
end
