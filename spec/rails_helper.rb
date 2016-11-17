if ENV['CI']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
  require 'scrutinizer/ocular'
  Scrutinizer::Ocular.watch!
end
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'sidekiq/testing'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!
Sidekiq::Testing.fake!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include ApiHelpers, type: :request

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
