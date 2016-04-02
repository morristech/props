require 'rails_helper'

describe PropsRepository do
  let(:repo) { described_class.new }

  describe '#all' do
    let!(:prop1) { create(:prop) }
    let!(:prop2) { create(:prop) }

    it 'returns all the props' do
      expect(repo.all).to eq [prop1, prop2]
    end
  end

  describe '#add' do
    let(:jack) { create(:user) }
    let(:jane) { create(:user) }
    let(:john) { create(:user) }
    let(:user_ids) { "#{john.id},#{jane.id}" }
    let(:attributes) do
      {
        body: FFaker::Lorem.paragraph,
        user_ids: user_ids,
        propser_id: jack.id,
      }
    end

    context 'with valid attributes' do
      it 'creates a prop' do
        expect { repo.add(attributes) }.to change { Prop.count }.by(1)
      end

      it "doesn't create a prop when propser is included in users" do
        attrs = attributes.merge(propser_id: jane.id)
        expect { repo.add(attrs) }.to_not change { Prop.count }
      end
    end

    context 'with invalid attributes' do
      it "doesn't raise an error when user_ids param is missing" do
        expect { repo.add({}) }.to_not raise_exception
      end
      context 'when user_ids is empty' do
        let(:user_ids) { '' }
        it "doesn't create a prop" do
          expect { repo.add(attributes) }.to_not change { Prop.count }
        end

        it "doesn't raise an error" do
          expect { repo.add(attributes) }.to_not raise_exception
        end
      end

      context 'when user_ids is an empty array' do
        let(:user_ids) { '[]' }
        it "doesn't create a prop" do
          expect { repo.add(attributes) }.to_not change { Prop.count }
        end

        it "doesn't raise an error" do
          expect { repo.add(attributes) }.to_not raise_exception
        end
      end

      context 'when @here present in body' do
        let(:invalid_attributes) { attributes.merge(body: 'Some body with @here') }
        it "doesn't create a prop" do
          expect { repo.add(invalid_attributes) }.to_not change { Prop.count }
        end

        it "doesn't raise an error" do
          expect { repo.add(attributes) }.to_not raise_exception
        end
      end

      context 'when @here present in body' do
        let(:invalid_attributes) { attributes.merge(body: '@channel in body oh no!') }
        it "doesn't create a prop" do
          expect { repo.add(invalid_attributes) }.to_not change { Prop.count }
        end

        it "doesn't raise an error" do
          expect { repo.add(attributes) }.to_not raise_exception
        end
      end
    end
  end
end
