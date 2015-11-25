class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  

  
  
  #def index
    #@users = User.all
    #@users = User.paginate(page: params[:page])
  #end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
       # UserMailer.account_activation(@user).deliver_now
       @user.send_activation_email
       flash[:info] = "Please check your email to activate your account."
       redirect_to root_url
       # equivalent to redirect_to user_url(@user)
       # Handle a successful save.
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(user_params)
      # Handle a successful update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  
  def manage
    @user = User.find(params[:id])
    @clubs = @user.clubs
    @posts = @user.posts
    #@group = Group.find(params[:id])
    #@members = @group.users # this will find the group users
  end
  
  
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  
  
  private

    def user_params
      params.require(:user).permit(:firstname, :lastname, :name, :email, :password,
                            :password_confirmation, :gender, :birthday, :phone, :degree, :major, :avatar)
    end
  
    # Before filters

   
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
     # redirect_to(root_url) unless @user == current_user
     redirect_to(root_url) unless current_user?(@user)
    end
    
     # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
   
end
