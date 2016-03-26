require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "test", email: "test@example.com", password: "password", is_admin: true)
  end

  test "get new category form and create category" do
    login_user(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: 'sports'}
    end
    assert_template 'categories/index'
    assert_match "sports", response.body
  end
  
  test "invalid category submission results in failure" do
    login_user(@user, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, category: {name: ''}
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title' # check for an h2 element with class panel-title (from errors partial)
    assert_select 'div.panel-body' # check for an div element with class panel-body (from errors partial)
  end
  
end
