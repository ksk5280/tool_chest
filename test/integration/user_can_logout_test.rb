require 'test_helper'

class UserCanLogoutTest < ActionDispatch::IntegrationTest
  test "logged in user can logout" do
    user_logs_in

    assert page.has_content? "Welcome #{@user.username}!"

    click_link "Logout"
    refute page.has_content? "Welcome #{@user.username}"
  end
end
