require 'rails_helper'

describe Rankings::ProcessTimeRange do
  subject { described_class.new(time_range_string) }

  describe '#time_range' do
    context 'when time range string is improper' do
      let(:time_range_string) { 'super_long' }

      it 'raises an error' do
        expect(subject.time_range).to raise_error('Wrong time range')
      end
    end

    # it 'one week time range' do
    # end
  end
end
