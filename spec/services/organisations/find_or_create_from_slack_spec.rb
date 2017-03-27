require 'rails_helper'

describe Organisations::FindOrCreateFromSlack do
  let(:subject) { described_class.new(attributes).call }
  let(:status) { subject[0] }
  let(:organisation) { subject[1] }

  describe 'with valid attributes' do
    let(:attributes) do
      {
        name: 'My Company',
        subdomain: 'my-company',
        image_url: 'https://placekitten.com/200/305',
        slack_uid: 'XX_1',
      }
    end

    it 'creates organisation record' do
      expect(status).to eq :created
      expect(organisation).to be_persisted
      expect(organisation.name).to eq 'My Company'
      expect(organisation.subdomain).to eq 'my-company'
      expect(organisation.image_url).to eq 'https://placekitten.com/200/305'
      expect(organisation.slack_uid).to eq 'XX_1'
    end

    context 'organisation already exists' do
      let!(:existing_organisation) { described_class.new(attributes).call[1] }

      it 'fetches organisation record' do
        expect(status).to eq :found
        expect(organisation).to eq existing_organisation
        expect(Organisation.count).to eq 1
      end
    end
  end

  describe 'with invalid attributes' do
    let(:attributes) do
      {
        name: 'My Company',
        subdomain: '',
        image_url: 'https://placekitten.com/200/305',
        slack_uid: 'XX_1',
      }
    end

    it "doesn't create organisation record" do
      expect(status).to eq :error
      expect(organisation).to_not be_persisted
      expect(organisation.errors).to be_present
    end
  end
end
