require 'rails_helper'

RSpec.describe NotifierJob, type: :job do
  include ActiveJob::TestHelper

  let(:prop) { create(:prop) }
  let(:notifier) { double }
  subject { described_class.perform_later(prop.id) }

  before do
    allow(Notifier).to receive(:new) { notifier }
  end

  it 'adds job to queue' do
    expect { subject }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by 1
  end

  it 'executes perform' do
    expect(notifier).to receive(:call)
    perform_enqueued_jobs { subject }
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
