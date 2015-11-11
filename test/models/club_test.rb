require 'test_helper'

class ClubTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:first_user) 
    #@club = clubs(:first_club)
    # This code is not idiomatically correct.
    @club = Club.new(name: "AnimeClub", description: "Anime", genre: "Arts", user_id: @user.id)
  end

  test "should be valid" do
    assert @club.valid?
  end

  # presence tests
  
  test "user id should be present" do
    @club.user_id = nil
    assert_not @club.valid?
  end
  
  test "club name should be present" do 
    @club.name = nil
    assert_not @club.valid?
  end
  
  test "description should be present" do 
    @club.description = nil
    assert_not @club.valid?
  end
  
  test "club genre should be present" do 
    @club.genre = nil
    assert_not @club.valid?
  end
  
  # length tests
  
  test "description should be at most 1000 characters" do
     @club.description = "a" * 1001
    assert_not  @club.valid?
  end
  
   test "title should be at most 70 characters" do 
     @club.name = "a" * 71
    assert_not  @club.valid?
  end
  
  test "title should be at most 50 characters" do
     @club.genre = "a" * 51
    assert_not  @club.valid?
  end
  
  # unique test
  
  test "name should be unique" do
    duplicate_club = @club.dup
    duplicate_club.name = @club.name.upcase
    @club.save
    assert_not duplicate_club.valid?
  end
  
end
