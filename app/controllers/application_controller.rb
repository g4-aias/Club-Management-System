class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  
  
  
  
  def build_club_path(club)
        view_club_path(path: club.path)
  end
  helper_method :build_club_path
  
  def build_post_path(post)
    view_club_post_path(path: post.club.path, post_id: post.id)
  end
  helper_method :build_post_path
  
  

  
  
   private
   # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    
    


    def set_time_zone
      Time.zone = current_user.time_zone
    end

end
