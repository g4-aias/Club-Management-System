require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = users(:first_user) 
    @club = clubs(:first_club)
    # This code is not idiomatically correct.
    @post = Post.new(context: "Lorem ipsum", title: "Bobs first post", user_id: @user.id, club_id: @club.id)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end
  
  test "club id should be present" do
    @post.club_id = nil
    assert_not @post.valid?
  end
  
  test "title should be present" do 
    @post.title = nil
    assert_not @post.valid?
  end
  
  test "context should be present" do 
    @post.context = nil
    assert_not @post.valid?
  end
  
  test "context should be at most 1000 characters" do
    @post.context = "a" * 1001
    assert_not @post.valid?
  end
  
   test "title should be at most 60 characters" do
    @post.title = "a" * 61
    assert_not @post.valid?
  end
  
  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end
  
  
  

end
