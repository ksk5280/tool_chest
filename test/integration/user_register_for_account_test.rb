require 'test_helper'

class UserRegisterForAccountTest < ActionDispatch::IntegrationTest
  test "user can create a valid account" do
    visit '/'
    click_link "Register"
    fill_in "Username", with: "Kimiko"
    fill_in "Password", with: "password"
    click_on "Create Account"

    user = User.last

    assert_equal "/users/#{user.id}", current_path
    assert page.has_content? "Welcome #{user.username}!"
  end
end
