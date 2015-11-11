require 'simplecov'
require 'fileutils'

SimpleCov.start         'rails'
SimpleCov.coverage_dir  'coverage/rspec'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/poltergeist'

require 'sidekiq/testing'

Capybara.javascript_driver = :poltergeist
Capybara.default_wait_time = 5

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.include Devise::TestHelpers, :type => :controller
  config.include Devise::TestHelpers, :type => :helper
  config.include FactoryGirl::Syntax::Methods
  config.include Capybara::DSL
  config.include AuthenticatedTestHelper
  config.extend AuthenticationMacros

  config.use_transactional_fixtures                 = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order                                      = "random"
  
  # Database cleaner
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end