require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "test", email: "test@example.com", password: "password", is_admin: true)
  end
  
  test "get create article form and create new article" do
    login_user(@user, "password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: {title: 'Title', description: 'Article Description'}
    end
    assert_template 'articles/show'
    assert_match "Article Description", response.body
  end

end
