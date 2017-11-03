ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'fileutils'


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

  #Carrierwave setup and teardown
  carrierwave_template = Rails.root.join('test','fixtures','files')
  $carrierwave_root = Rails.root.join('test','support','carrierwave')

  #Carrierwave configuration for tests
  CarrierWave.configure do |config|
    config.root = $carrierwave_root
    config.enable_processing = false
    config.storage = :file
    config.cache_dir = Rails.root.join('test','support','carrierwave','carrierwave_cache')
  end

  puts "Removing old carrierwave test directories:"
  Dir.glob($carrierwave_root.join('*')).each do |dir|
    puts " #{dir}"
    FileUtils.remove_entry(dir)
  end

  # Copy carrierwave template in
  puts "Copying\n  #{carrierwave_template.join('uploads').to_s} to\n  #{$carrierwave_root.to_s}"
  FileUtils.cp_r carrierwave_template.join('uploads'), $carrierwave_root

end
