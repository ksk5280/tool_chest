require 'test_helper'

class UserCanSeeCategoriesTest < ActionDispatch::IntegrationTest
  test "logged in user can see categories index and show pages" do
    category = Category.create(name: "Gardening Tools")
    user_logs_in
    user_id = User.find_by(username: "Kimiko").id
    tool = category.tools.create(name: "Rake", quantity: 10, price: 1099, user_id: user_id)

    visit '/'
    click_link "Categories"
    assert_equal categories_path, current_path
    assert page.has_content? "Tool Categories"
    assert page.has_content? "Gardening Tools"

    click_link "Gardening Tools"
    assert page.has_content? "Rake"
  end
end
