require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end
 
 #test "show first user" do
   # get (:show, {'id' => "1"})
  #  assert_response :success
 # end
end
