require 'rails_helper'

describe NewPropNotification do
  let(:giver) { 'Kenny' }
  let(:receivers) { %w(Bart Cartman Stan) }

  describe '#body' do
    subject { described_class.new(receivers, giver, content).body }

    context 'when prop is single line' do
      let(:content) { 'Single line prop' }
      let(:part_of_expected_result) do
        "_#{content}_"
      end

      it 'returns italized content' do
        expect(subject).to include(part_of_expected_result)
      end
    end

    context 'when prop is multi line' do
      let(:content) { "Multi\nline\nprop" }
      let(:part_of_expected_result) do
        "_Multi_\n_line_\n_prop_"
      end

      it 'returns italizes each line in content' do
        expect(subject).to include(part_of_expected_result)
      end
    end
  end
end
