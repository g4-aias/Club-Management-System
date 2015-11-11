require 'test_helper'

class ClubsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @club = clubs(:first_club)
    @other_club = clubs(:first_club)
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Club.count' do
      post :create, club: { name: "Lorem ipsum", description: "Lorem ipsum", genre: "Lorem ipsum"}
    end
    assert_redirected_to login_url
  end
  

end
