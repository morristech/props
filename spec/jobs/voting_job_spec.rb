require 'rails_helper'

RSpec.describe VotingJob, type: :job do
  include ActiveJob::TestHelper

  # let(:prop) { create(:prop, slack_ts: '123.321') }

  let(:reaction_symbol) { '+1' }
  let(:ts) { '123.321' }
  let(:uid) { '123' }
  let(:type) { 'reaction_added' }
  let(:reaction) { double() }

  subject { described_class.perform_later(reaction_symbol, ts, uid, type) }

  before do
    allow(Reaction).to receive(:new) { reaction }
  end

  it 'adds job to queue' do
    expect { subject }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by 1
  end

  it 'executes perform' do
    expect(reaction).to receive(:upvote)
    perform_enqueued_jobs { subject }
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
