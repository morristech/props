require 'rails_helper'

describe 'bundler_audit:audit' do
  include_context 'rake'

  it 'updates the ruby-advisory-db and runs audit' do
    expect(Bundler::Audit::CLI).to receive(:start).with(['update'])
    expect(Bundler::Audit::CLI).to receive(:start).with(['check'])
    Rake.application['bundler:audit'].invoke
  end
end
