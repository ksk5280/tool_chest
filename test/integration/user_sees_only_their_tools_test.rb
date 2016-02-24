require 'test_helper'

class UserSeesOnlyTheirToolsTest < ActionDispatch::IntegrationTest
  test "logged in user sees only their own tools" do
    user_logs_in

    assert page.has_content? "Welcome #{@user.username}"
    assert "/users/#{@user.id}", current_path

    click_link "See all tools in tool chest"

    
  end
end
