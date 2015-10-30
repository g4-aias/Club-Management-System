require 'test_helper'


class WelcomeControllerTest < ActionController::TestCase
  def setup
    @base_title = "G4 app"
  end

  test "should get welcomepage" do
    get :welcomepage
    assert_response :success
    assert_select "title", "#{@base_title} | Welcome"
  end

  test "should get terms" do
    get :terms
    assert_response :success
    assert_select "title", "#{@base_title} | Terms"
  end
  
  test "should get privacy" do
    get :privacy
    assert_response :success
    assert_select "title", "#{@base_title} | Privacy"
  end
  
  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "#{@base_title} | About"
  end
  
   test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "#{@base_title} | Contact"
  end
  
  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "#{@base_title} | Help"
  end
end
