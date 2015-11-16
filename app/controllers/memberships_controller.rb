class MembershipsController < ApplicationController
  before_action :set_club
  
  def create
    #if club is free join... then do Membership.subscribe!(@club, current_user)
    target_user = params[:target_user_param]
    if Membership.subscribe!(@club, target_user)
      flash[:success] = "Request Approved" 
      redirect_to manage_club_path(path: @club.path)
    else
      flash[:danger] = 'ERROR: There was an error processing your request'
      redirect_to root_url
    end
  end

  def destroy
    Membership.unsubscribe!(@club, current_user)
    flash[:success] = "You have successfully left the club" 
    redirect_to view_club_path(path: @club.path)
  end
  
  private
  
  def set_club
    @club = Club.find(params[:club_id])
  end
  
end
