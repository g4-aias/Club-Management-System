class MemberRequestsController < ApplicationController
  before_action :set_club
  before_action :request_check, only: :create
  
  #create and send the request
  def create
    if MemberRequest.req!(@club, current_user)
      flash[:success] = "Request Sent!" 
      redirect_to view_club_path(path: @club.path)
    else
      flash[:danger] = 'ERROR: There was an error processing your request'
      redirect_to root_url
    end
  end

  #destroy request directly from rejection
  def destroy
    target_user = params[:target_user_param]
    member_request = MemberRequest.where(club_id: @club.id, user_id: target_user).first
    return false unless member_request
    member_request.destroy
    flash[:success] = "Request Rejected!"
    redirect_to manage_club_path(path: @club.path)
  end
  
  private

  def set_club
    @club = Club.find(params[:club_id])
  end
  
  def request_check
    if MemberRequest.request_exists?(@club, current_user)
      flash[:danger] = 'ERROR: Request is pending'
      redirect_to view_club_path(path: @club.path)
    end
  end
end
