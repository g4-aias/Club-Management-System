require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get welcomepage" do
    get :welcomepage
    assert_response :success
    assert_select "title", "G4 app | Welcome"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "G4 app | About"
  end
  
   test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "G4 app | Contact"
  end
end
