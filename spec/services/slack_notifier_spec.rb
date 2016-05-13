require 'rails_helper'

describe Notifier::SlackNotifier do
  let(:prop) { create(:prop) }
  let(:notification) { NewPropNotification.new(prop) }

  subject { described_class.new(notification) }

  describe '#call' do
    context 'slack bot is configured properly' do
      before do
        allow(subject.send(:channel)).to receive(:chat_postMessage).and_return(ts: 'test_ts')
      end

      it 'should update slack_ts attribute' do
        expect { subject.call }.to change(prop, :slack_ts).to('test_ts')
      end
    end

    context 'slack bot is not configured' do
      it 'should not update slack_ts' do
        expect { subject.call }.to_not change(prop, :slack_ts)
      end
    end
  end
end
