require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = users(:first_user) 
    @club = clubs(:first_club)
    @post = posts(:first_post)
    @comment = Comment.new(comment: "Frist comment", user_id: @user.id)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "comment should be present" do
    @comment.comment = nil
    assert_not @comment.valid?
  end
  
  test "conment should be at most 200 characters" do
    @comment.comment = "a" * 201
    assert_not @comment.valid?
  end
  
  test "order should be most recent first" do
    assert_equal comments(:most_recent), Comment.first
  end
  
end
