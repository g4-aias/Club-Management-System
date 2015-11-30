require 'test_helper'

class ClubsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:second_user)
    @club = clubs(:first_club)
    @other_club = clubs(:first_club)
  end
  
  test "should get club index" do
    #calls the function "index" in controller
    get :index
    assert_response :success
  end
  
  test "should redirect to login when accessing club new" do
    get :new
    #becuse our controller has a before action that redirects to login url if user is not logged in
    assert_redirected_to login_url
  end
  
  test "should get show page" do
    get :show , path: @club.path
    assert_response :success
  end
  
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Club.count' do
      post :create, club: { name: "Lorem ipsum", description: "Lorem ipsum", genre: "Lorem ipsum"}
    end
    assert_redirected_to login_url
  end
  
  test "should redirect when accessing manage page not logged in " do
    get :manage , path: @club.path
    assert_redirected_to login_url
  end
  
  test "redirect when user is not a mod manage " do
    log_in_as(@user)
    get :manage, path: @club.path
    assert_response :redirect
  end
  
  test "should redirect when accessing edit page not logged in " do
    get :edit, id: @club.id
    assert_redirected_to login_url
  end
  
  test "redirect when user is not a mod edit " do
    log_in_as(@user)
    get :edit, id: @club.id
    assert_response :redirect
  end
  
  test "should redirect when accessing show members page not logged in " do
    get :show_members, path: @club.path
    assert_redirected_to login_url
  end
  
  test "redirect when user is not a mod show members " do
    log_in_as(@user)
    get :show_members, path: @club.path
    assert_response :redirect
  end
  
  test "should redirect when accessing manage_requests page not logged in " do
    get :manage_requests, path: @club.path
    assert_redirected_to login_url
  end
  
  test "redirect when user is not a mod manage_requests " do
    log_in_as(@user)
    get :manage_requests, path: @club.path
    assert_response :redirect
  end
  
  test "should redirect when accessing add_moderator page not logged in " do
    get :add_moderator, path: @club.path
    assert_redirected_to login_url
  end
  
  test "redirect when user is not a mod add_moderator " do
    log_in_as(@user)
    get :add_moderator, path: @club.path
    assert_response :redirect
  end


  test "should redirect when attempting to send a mod request while not logged in " do
    get :mod_request, path: @club.path
    assert_redirected_to login_url
  end
  
  test "should redirect when attempting to update a update_modrequest while not logged in " do
    get :update_modrequest, path: @club.path
    assert_redirected_to login_url
  end
  
end
