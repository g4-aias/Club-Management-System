class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
   
    if @user.save
       @user.email = @user.email + "@sfu.ca"
       @user.save
       flash[:success] = "Welcome to Our App!"
      redirect_to @user
      # equivalent to redirect_to user_url(@user)
      # Handle a successful save.
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:firstname, :lastname, :name, :email, :password,
                                   :password_confirmation)
    end
  
  
  
end
