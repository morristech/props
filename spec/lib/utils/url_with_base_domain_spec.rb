require 'spec_helper'
require_relative '../../../lib/utils/url_with_base_domain'

describe Utils::UrlWithBaseDomain do
  describe '#subdomain' do
    it 'returns subdomain from base domain' do
      url = described_class.new('http://aaa.bbb.pl/stuff', 'bbb.pl')

      expect(url.subdomain).to eq('aaa')
    end
  end

  describe '#to_s' do
    it 'returns current state of the uri' do
      url = described_class.new('http://aaa.bbb.pl/stuff', 'bbb.pl')

      expect(url.to_s).to eq('http://aaa.bbb.pl/stuff')
    end
  end

  describe '#subdomain=' do
    it 'changes subdomain in the uri' do
      uri = described_class.new('http://aaa.bbb.pl/stuff', 'bbb.pl')

      uri.subdomain = 'test'

      expect(uri.to_s).to eq('http://test.bbb.pl/stuff')
    end
  end

end
