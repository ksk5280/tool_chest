require 'test_helper'

class AdminSeesAllToolsTest < ActionDispatch::IntegrationTest
  test "logged in admin sees all tools on admin tool path" do
    admin = User.create(username: "Kimi",
                        password: "password",
                        role: 1)

    user1 = User.create(username: "user1", password: "password")
    user2 = User.create(username: "user2", password: "password")
    tool1 = user1.tools.create(name: "screwdriver", quantity: 10, price: 1000)
    tool2 = user2.tools.create(name: "hammer", quantity: 5, price: 500)

    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    
    visit admin_tools_path

    assert page.has_content? "#{user1.tools.first.name} - #{user1.tools.first.quantity}"
    assert page.has_content? "#{user2.tools.first.name} - #{user2.tools.first.quantity}"
  end
end
