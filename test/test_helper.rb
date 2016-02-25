ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'minitest/pride'
require 'mocha/mini_test'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    DatabaseCleaner.start
  end

  def teardown
    reset_session!
    DatabaseCleaner.clean
  end

  def user_logs_in
    @user = User.create(username: "Kimiko", password: "password", role: 0)

    visit login_path
    fill_in "Username", with: @user.username
    fill_in "Password", with: "password"
    click_button "Login"
  end
end
