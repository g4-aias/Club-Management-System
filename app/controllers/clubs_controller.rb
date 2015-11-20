class ClubsController < ApplicationController
    before_action :logged_in_user, only: [:create, :new]
    before_action :find_club_path, only: [:show, :manage]
    #before_action :show_all_clubs,     only: :index
    
    def index
        #@clubs = Club.all
        @clubs = Club.all.paginate(page: params[:page], :per_page => 10)
        if params[:search]
            @clubs = Club.search(params[:search]).paginate(page: params[:page])
        #elsif params[:sort].present?
            #@clubs = Club.sort(params[:sort]).paginate(page: params[:page])
        else
            @clubs = Club.all.paginate(page: params[:page], :per_page => 5)
        end
    end

    def new 
        @club = Club.new
    end
    
    def create
        @club = current_user.clubs.build(club_params)
        if@club.save
                flash[:success] = "Club Created" 
                #redirects to club homepage
                redirect_to manage_club_path(path: @club.path)
        else
            render 'new'
        end
    end
    
    def show
        #returns all posts that belongs to the club
        @posts = @club.posts.paginate(page: params[:page])
    end
    
    def manage
        #@user = User.find(params[:id])
        #@clubs = @user.clubs
        
        @member_requests = @club.member_requests
        
    end
    
    private
    def club_params
        params.require(:club).permit(:name, :description, :path, :genre)
    end
    
    def find_club_path
        @club = Club.by_path(params[:path])
    end
    

end

