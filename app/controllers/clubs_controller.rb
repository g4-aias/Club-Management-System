class ClubsController < ApplicationController
    before_action :logged_in_user, except: [:show, :index]
    before_action :find_club_path, only: [:show, :manage, :show_members, :manage_requests, :add_moderator, :mod_request, :update_modrequest]
    before_action :set_club, only: [:edit, :update]
    layout 'club' , except: :index
    #before_action :can_moderate?,     only: [:manage, :edit]
    
    def index
        #@clubs = Club.all
        @clubs = Club.all.paginate(page: params[:page], :per_page => 10)
        if params[:search]
            @clubs = Club.search(params[:search]).paginate(page: params[:page])
        #elsif params[:sort].present?
            #@clubs = Club.sort(params[:sort]).paginate(page: params[:page])
        else
            #@clubs = Club.all.paginate(page: params[:page], :per_page => 5)
            @clubs = Club.order(:name).paginate(page: params[:page], :per_page => 5)
           
        end
            
    end

    def new 
        @club = Club.new
    end
    
    def create
        @club = current_user.clubs.build(club_params)
        if @club.save
                flash[:success] = "Club Created" 
                #redirects to club homepage
                redirect_to manage_club_path(path: @club.path)
        else
            render 'new'
        end
    end
    
    # show by likes
    def show
        @posts = @club.posts.by_hot_score.latest.five_days_ago.paginate(page: params[:page])
        @moderators = @club.moderators
    end
    
    def manage
        unless @club.is_moderator?(current_user)
            flash[:danger] = "You are not a moderator of this club" 
            redirect_to build_club_path(@club)
        end
        
        @member_requests = @club.member_requests 
    end
    
    def edit
        unless @club.is_moderator?(current_user)
            flash[:danger] = "You are not a moderator of this club" 
            redirect_to build_club_path(@club)
        end

    end
    
    def update
        if @club.update(club_params)
            redirect_to build_club_path(@club)
        else
            render :edit
        end
    end
    
    # shows all members that belong in the club
    def show_members 
        #@users = @club.members
        unless @club.is_moderator?(current_user)
            flash[:danger] = "You are not a moderator of this club" 
            redirect_to build_club_path(@club)
        end
        
        @users = User.all
    end
    
    # manage membership requests
    def manage_requests
        
        unless @club.is_moderator?(current_user)
            flash[:danger] = "You are not a moderator of this club" 
            redirect_to build_club_path(@club)
        end
        
        @member_requests = @club.member_requests
    end
    
    # view where the moderators can add new moderators to their club
    # the new function for moderator invitations
    def add_moderator
        unless @club.is_moderator?(current_user)
            flash[:danger] = "You are not a moderator of this club" 
            redirect_to build_club_path(@club)
        end
        
        @mod_request = ModRequest.new
    end
    
    # the create function for moderator invitations
    def mod_request
        @user = User.by_username_insensitive(params[:username])
        
        #function must exit if user is not found, hence the return
        if @user.nil?
            flash[:danger] = "User does not exist!" 
            redirect_to(:back) and return 
        end
        
        if @club.is_moderator?(@user)
            flash[:danger] = "User is already a moderator of this club" 
            redirect_to(:back) and return 
        end
        
         @mod_request = ModRequest.new(
          #target user
          user_id: @user.id,
          inviting_user_id: current_user.id,
          club_id: @club.id
        )
        
        if @mod_request.save
            flash[:success] = "Moderator request has been sent!"
            redirect_to :back
        else
            flash[:danger] = "Could not send a request at this time, try again later" 
            redirect_to :back
        end
    end
    
    # the update/destroy function for moderator invitations
    def update_modrequest
        
        @mod_request = ModRequest.where(user_id: current_user.id, club_id: @club.id)
                   .first
                   
        if @mod_request.nil?
          flash[:danger] = "Could not find moderator request." 
          redirect_to(:back) and return
        end
        
        #if the user is not a member, make him a member
        if @club.is_moderator?(current_user)
            flash[:danger] = "You are already a moderator of this club."
            redirect_to build_club_path(@club) and return
        end
        
        unless @club.is_member?(current_user)
          Membership.create!(user_id: current_user.id, club_id: @club.id)
        end
        
        @club.add_moderator!(current_user)
        
        @mod_request.destroy
        redirect_to build_club_path(@club)
    end
    
    
    private
    def club_params
        params.require(:club).permit(:name, :description, :path, :genre, :club_avatar, :backgroud)
    end
    
    def find_club_path
        @club = Club.by_path(params[:path])
        
        if @club.nil?
            flash[:danger] = "Unable to find the specified club" 
            redirect_to clubs_path
        end
    end
    
    def set_club
        @club = Club.find(params[:id])
        
        if @club.nil?
            flash[:danger] = "Unable to find the specified club" 
            redirect_to clubs_path
        end
    end
    

end

