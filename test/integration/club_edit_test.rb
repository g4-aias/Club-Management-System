require 'test_helper'

class ClubEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:first_user) 
  end

  test "Club interface" do
    log_in_as(@user)
    get new_club_path
    assert_select 'div'
    # Invalid submission
    assert_no_difference 'Club.count' do
      post clubs_path, club: { description: "",
                                name: name }
    end
     assert_no_difference 'Club.count' do
      post clubs_path, club: { description: "",
                                name: "" }
    end
     assert_no_difference 'Club.count' do
      post clubs_path, club: { description: "",
                                name: "" }
    end
     assert_select 'div#error_explanation'
      # Valid submission
      description = "This club descript"
      assert_difference 'Club.count', 1 do
        post clubs_path, club: { description: description,
                                name: name }
    end
  end







end