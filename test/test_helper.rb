ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'token_test_helper'

class ActiveSupport::TestCase
  PaperTrail.enabled = true

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  ActiveRecord::Migration.check_pending!
  DatabaseCleaner.strategy = :truncation
  setup { DatabaseCleaner.start }
  teardown { DatabaseCleaner.clean } 
end


class ActionController::TestCase
  include Devise::Test::ControllerHelpers

  DatabaseCleaner.strategy = :truncation
  setup { DatabaseCleaner.start }
  teardown { DatabaseCleaner.clean } 
end

module FixtureFileHelpers
  def encrypted_password(password = 'password123')
    User.new.send(:password_digest, password)
  end
end

ActiveRecord::FixtureSet.context_class.send :include, FixtureFileHelpers