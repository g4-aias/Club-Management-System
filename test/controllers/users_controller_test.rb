require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:first_user)
    @other_user = users(:second_user)
  end
  
  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end
  
  test "should get new" do
    get :new
    assert_response :success
  end
 
 #test "show first user" do
   # get (:show, {'id' => "1"})
  #  assert_response :success
 # end
 
  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { firstname: @user.firstname, lastname: @user.lastname, name: @user.name}
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: { firstname: @user.firstname, lastname: @user.lastname, name: @user.name}
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch :update, id: @other_user, user: { password:              @other_user.password,
                                            password_confirmation: @other_user.password_confirmation,
                                            admin: true }
    assert_not @other_user.reload.admin?
  end
 
 
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end
  
  
 
 
 
 
end
