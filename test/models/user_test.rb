require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = User.new(firstname: "Bobby", lastname: "chan", name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end
  
  #presence test
  
  test "firstname should be present" do
    @user.firstname = "     "
    assert_not @user.valid?
  end
  
  test "lastname should be present" do
    @user.lastname = "     "
    assert_not @user.valid?
  end
  
  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end
  
   test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  #max length test
  
  test "firstname should not be too long" do
    @user.firstname = ("a" * 51)
    assert_not @user.valid?
  end
  
  
  test "lastname should not be too long" do
    @user.lastname = ("a" * 51)
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = ("a" * 51)
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = (("a" * 244) + "@sfu.ca")
    assert_not @user.valid?
  end
  
  #min length test
  
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  
  #unique test
  
  test "name should be unique" do
    duplicate_user = @user.dup
    duplicate_user.name = @user.name.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    #assert_not @user.authenticated?('')
    assert_not @user.authenticated?(:remember, '')
  end
  
end
