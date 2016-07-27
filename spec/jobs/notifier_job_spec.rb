require 'rails_helper'

RSpec.describe NotifierJob, type: :job do
  include ActiveJob::TestHelper

  let(:notifier) { double }
  subject { described_class.perform_later(prop.id) }

  before do
    allow(Notifier).to receive(:new) { notifier }
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end

  context 'prop was not notified before' do
    let!(:prop) { create(:prop, slack_ts: nil) }

    it 'adds job to queue' do
      expect { subject }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by 1
    end

    it 'calls Notifier service' do
      expect(notifier).to receive(:call)
      perform_enqueued_jobs { subject }
    end
  end

  context 'prop with given id does not exist' do
    subject { described_class.perform_later(nil) }

    it 'does not call Notifier service' do
      expect(notifier).to_not receive(:call)
      perform_enqueued_jobs { subject }
    end
  end

  context 'prop was notified before' do
    let!(:prop) { create(:prop, slack_ts: '123.321') }

    it 'adds job to queue' do
      expect { subject }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by 1
    end

    it 'does not call Notifier service' do
      expect(notifier).to_not receive(:call)
      perform_enqueued_jobs { subject }
    end
  end
end
