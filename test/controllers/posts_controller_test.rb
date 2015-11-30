require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  def setup
    @user = users(:second_user)
    @member = users(:third_user)
    @club = clubs(:first_club)
    @post = posts(:first_post)
    @other_post = posts(:second_post)
  end
  
  # new
  test "should redirect new if user is not logged in" do
    get :new, path: @post.club.path
    assert_redirected_to login_url
  end
  
  test "should redirect new if user is logged in, but not a member" do
    log_in_as(@user)
    get :new, path: @post.club.path
    assert_equal 'Only members can create posts.', flash[:danger]
    assert_response :redirect
  end
  
  test "should successfully direct to new (authenticated)" do
    log_in_as(@member)
    get :new, path: @post.club.path
    assert flash.empty?
    assert_response :success
  end
  
  # show
  test "should show post even if user is not logged in" do
    get :show, path: @post.club.path, post_id: @post.id
    assert flash.empty?
    assert_response :success
  end
  
  # create
  test "should redirect create if user is not logged in" do
    get :create, path: @post.club.path
    assert_equal 'Please log in.', flash[:danger]
    assert_redirected_to login_url
  end
  
   test "should redirect create when not logged in" do
    assert_no_difference 'Post.count' do
      post :create, post: { content: "Lorem ipsum" }
    end
    assert_redirected_to login_url
  end
  
  test "should redirect create if user is logged in, but not a member" do
    log_in_as(@user)
    assert_no_difference 'Post.count' do
      post :create, club_path: @club.path, post: { content: "Lorem ipsum", title: "Lorem ipsum", url: "", image: "", clubpath: @club.path }
    end
    assert_equal 'Only members can create posts.', flash[:danger]
    assert_response :redirect
  end
  
  
  test "successful creation of a post" do
    log_in_as(@member)
    #assert_difference 'Post.count' do
      post :create, club_path: @club.path, post: { content: "Lorem ipsum", title: "Lorem ipsum" }
    #end
    assert flash.empty?
    assert_response :success
  end
  
  
  # destroy
  test "should redirect destroy if user is not logged in" do
    assert_no_difference 'Post.count' do
      delete :destroy, id: @post.id
    end
    assert_not flash.empty?
    assert_equal 'Please log in.', flash[:danger]
    assert_redirected_to login_url
  end
  
  
  test "should destroy as user is authenticated" do
    log_in_as(@member)
    assert_difference 'Post.count', -1 do
      delete :destroy, id: @post.id
    end
    assert_equal 'Post deleted', flash[:success]
  end
  
  # edit
  test "should redirect edit if user is not logged in" do
    get :edit, id: @post
    assert_equal 'Please log in.', flash[:danger]
    assert_redirected_to login_url
  end
  
  test "should redirect edit if user is logged in, but not a member" do
    log_in_as(@user)
    patch :update, id: @post, post: { content: "Lorem ipsum", title: "Lorem ipsum" }
    assert flash.empty?
    assert_response :redirect
  end
  
  test "successful edit if user is logged in (authenticated)" do
    log_in_as(@member)
    patch :update, id: @post, post: { content: "Lorem ipsum", title: "Lorem ipsum" }
    assert_equal 'Post Updated!', flash[:success]
  end
  
end