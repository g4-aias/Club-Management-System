require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
   def setup
    @user = users(:first_user)
   end
   
   test "profile display" do
     get user_path(@user)
     assert_template 'users/show'
     #assert_select 'title', text: @user.name
     #looks for the h1 tag and checks if @user.name is there
     assert_select 'h1', text: @user.name
   end

   
        
end
