require 'rails_helper'

describe NewPropNotification do
  let(:giver) { create(:user, name: 'Kenny') }
  let(:receivers) do
    [
      create(:user, name: 'Bart'),
      create(:user, name: 'Simmons'),
    ]
  end

  describe '#body' do
    let(:prop) { Prop.new(propser: giver, users: receivers, body: content) }
    subject { described_class.new(prop).body }

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
