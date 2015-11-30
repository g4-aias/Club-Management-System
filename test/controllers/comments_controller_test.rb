require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:second_user)
    @member = users(:third_user)
    @club = clubs(:first_club)
    @post = posts(:first_post)
    @other_post = posts(:second_post)
    @comment = comments(:first_comment)
  end
  
  # new
  test "should redirect new if no user is logged in" do
    get :new, post_id: @post.id
    assert_equal 'Please log in.', flash[:danger]
    assert_redirected_to login_url
  end
  
  test "should redirect new if user is logged in, but not a member" do
    log_in_as(@user)
    get :new, post_id: @post.id
    path = @club.path
    id = @post.id
    assert_equal 'Please become a member of this club to use this function.', flash[:danger]
    assert_redirected_to %r{\Ahttp://test.host/p/#{path}/#{id}\Z}
  end
  
  test "successful new if user is logged in (authenticated)" do
    log_in_as(@member)
    get :new, post_id: @post.id
    assert flash.empty?
    assert_response :success
  end
  
  # create
  test "should redirect create if no user is logged in" do
    assert_no_difference 'Comment.count' do
      post :create, post_id: @post.id, comment: { comment: "Hello World", parent_id: "" }
    end
    assert_equal 'Please log in.', flash[:danger]
    assert_redirected_to login_url
  end
    
  test "should redirect create if user is logged in, but not a member" do
    log_in_as(@user)
    assert_no_difference 'Comment.count' do
      post :create, post_id: @post.id, comment: { comment: "Hello World", parent_id: "" }
    end
    assert_equal 'Please become a member of this club to use this function.', flash[:danger]
  end
  
  test "successful create if user is logged in (authenticated)" do
    log_in_as(@member)
    assert_difference 'Comment.count' do
      post :create, post_id: @post.id, comment: { comment: "Hello World", parent_id: "" }
    end
  end
  
  # destroy
  test "should redirect destroy if no user is logged in" do
    assert_no_difference 'Comment.count' do
      delete :destroy, post_id: @post.id, id: @comment.id
    end
    assert_equal 'Please log in.', flash[:danger]
    assert_redirected_to login_url
  end
  
  test "should redirect destroy if user is logged in, but not the owner" do
    log_in_as(@user)
    assert_no_difference 'Comment.count' do
      delete :destroy, post_id: @post.id, id: @comment.id
    end
    assert flash.empty?
    assert_response :redirect
  end
  
  test "successful destroy if user is logged in (authenticated)" do
    log_in_as(@member)
    assert_difference 'Comment.count', -1 do
      delete :destroy, post_id: @post.id, id: @comment.id
    end
  end
  
  # edit
  test "should redirect edit if no user is logged in" do
    get :edit , post_id: @post.id, id: @comment.id
    assert_equal 'Please log in.', flash[:danger]
    assert_redirected_to login_url
  end
  
  test "should redirect edit if user is logged in, but not a member" do
    log_in_as(@user)
    get :update , post_id: @post.id, id: @comment.id, comment: { comment: "Hello World 2", parent_id: "" }
    assert_not_equal 'Comment Updated!', flash[:success]
  end
  
  test "successful updated if user is logged in (authenticated)" do
    log_in_as(@member)
    get :update , post_id: @post.id, id: @comment.id, comment: { comment: "Hello World 2", parent_id: "" }
    assert_equal 'Comment Updated!', flash[:success]
  end
  
  
end
