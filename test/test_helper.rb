ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end
  
  teardown do
    Rails.cache.clear
    sign_out @user
  end

end
