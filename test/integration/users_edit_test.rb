require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:first_user)
  end


  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { firstname: "",
                                    lastname: "kod",
                                    name:  "",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_template 'users/edit'
  end
  
  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    firstname = "BOB"
    lastname = "nod"
    name  = "Foo Bar"
    patch user_path(@user), user: { firstname: firstname,
                                    lastname: lastname,
                                    name:  name,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal firstname, @user.firstname
    assert_equal lastname, @user.lastname
    assert_equal name,  @user.name
  end
  
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    firstname = "BOB"
    lastname = "nod"
    name  = "Foo Bar"
    patch user_path(@user), user: { firstname: firstname,
                                    lastname: lastname,
                                    name:  name,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal firstname, @user.firstname
    assert_equal lastname, @user.lastname
    assert_equal name,  @user.name
  end
  
  
  
end
