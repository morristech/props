require 'rails_helper'

describe UpvotesRepository do
  let(:repo) { described_class.new }
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:prop) { create(:prop) }

  describe '#add' do
    let(:upvote) { Upvote.last }

    it 'creates an upvote' do
      expect { repo.add(prop, user) }.to change(Upvote, :count).by(1)
    end

    it 'increments upvotes_count on props' do
      expect do
        repo.add(prop, user)
      end.to change { prop.reload.upvotes_count }.by(1)
    end
  end

  describe '#remove' do
    before { repo.add(prop, user) }

    context 'user upvoted the prop' do
      it 'removes an upvote' do
        expect { repo.remove(prop, user) }.to change(Upvote, :count).by(-1)
      end

      it 'decrements upvotes_count on props' do
        expect { repo.remove(prop, user) }.to change { prop.reload.upvotes_count }.by(-1)
      end
    end

    context 'different user upvoted the prop' do
      it 'removes an upvote' do
        expect { repo.remove(prop, user2) }.to change(Upvote, :count).by(0)
      end

      it 'decrements upvotes_count on props' do
        expect { repo.remove(prop, user2) }.to change { prop.reload.upvotes_count }.by(0)
      end
    end
  end
end
