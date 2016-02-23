require 'test_helper'

class UserCanLoginTest < ActionDispatch::IntegrationTest
  test "registered user can login with valid username and password" do
    user = User.create(username: "Kimiko", password: "password")

    visit login_path
    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_button "Login"

    assert page.has_content? "Welcome #{user.username}!"
  end
end
