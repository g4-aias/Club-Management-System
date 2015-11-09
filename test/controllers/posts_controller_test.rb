require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  def setup
    @post = posts(:first_post)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post :create, post: { content: "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end

end