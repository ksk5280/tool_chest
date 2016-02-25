require 'test_helper'

class UserRegistersForAccountTest < ActionDispatch::IntegrationTest
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

  test "user cannot create an account with a non-unique username" do
    user = User.create(username: "Kimiko", password: "password")

    visit '/'
    click_link "Register"
    fill_in "Username", with: "Kimiko"
    fill_in "Password", with: "password2"

    click_on "Create Account"

    assert page.has_content? "Username is already taken"
  end
end
