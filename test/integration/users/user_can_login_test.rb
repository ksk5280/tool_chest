require 'test_helper'

class UserCanLoginTest < ActionDispatch::IntegrationTest
  test "registered user can login with valid username and password" do
    user_logs_in

    assert page.has_content? "Welcome #{@user.username}!"
  end
end
