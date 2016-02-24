require 'test_helper'

class UserSeesOnlyTheirToolsTest < ActionDispatch::IntegrationTest
  test "logged in user sees only their own tools" do
    user1 = User.create(username: "user1", password: "password")
    user2 = User.create(username: "user2", password: "password")
    tool1 = user1.tools.create(name: "screwdriver", quantity: 10, price: 1000)
    tool2 = user2.tools.create(name: "hammer", quantity: 5, price: 500)

    visit login_path
    fill_in "Username", with: user1.username
    fill_in "Password", with: "password"
    click_button "Login"

    assert page.has_content? "Welcome #{user1.username}"
    assert "/users/#{user1.id}", current_path
    click_link "See all tools in tool chest"

    assert page.has_content? "#{user1.tools.first.name} - #{user1.tools.first.quantity}"
    refute page.has_content? "#{user2.tools.first.name} - #{user2.tools.first.quantity}"

    click_link "Logout"

    fill_in "Username", with: user2.username
    fill_in "Password", with: "password"
    click_button "Login"

    assert page.has_content? "Welcome #{user2.username}"
    assert "/users/#{user2.id}", current_path
    click_link "See all tools in tool chest"

    assert page.has_content? "#{user2.tools.first.name} - #{user2.tools.first.quantity}"
    refute page.has_content? "#{user1.tools.first.name} - #{user1.tools.first.quantity}"
  end
end
