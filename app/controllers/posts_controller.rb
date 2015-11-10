class PostsController < ApplicationController
    
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user,   only: :destroy
    before_action :authorized_member?, only: [:create, :new]
    
    def new
        @club = nil
        @club = Club.by_path(params[:path]) if params[:path]
        @post = Post.new

    end
    
    def create
        @post = Post.new(post_params)
        @club = Club.by_path(params[:club_path]) if params[:club_path]
        if @club.nil?
            flash[:danger] = 'ERROR: Could not find the specificed club'
            redirect_to root_path and return
        end
        
        @post.club = @club
        @post.user_id = current_user.id
        if @post.save
            flash[:success] = "Post created!"
            #the path for post#show is
            #p/:path/:post_id
            #redirect_to view_club_post_path(path: @post.club.path, post_id: @post.id)
            redirect_to build_post_path(@post)
        else
            render :new
        end
    end
    
    def show
        #because p/:path/:post_id = post#show
        #we cant do @post = Post.find(params[:id]) as :id is no longer defined 
        @post = Post.where(id: params[:post_id]).first
        if @post.nil?
            flash[:danger] = 'ERROR: Post does not exist'
            redirect_to root_path and return
        end
    end
     
    def destroy
        @post.destroy
        flash[:success] = "Post deleted"
        redirect_to request.referrer || root_url
    end


    private
    
    def post_params
        params.require(:post).permit(:context, :title, :url, :club_id, :picture)
    end
    
    def authorized_member?
        @club = Club.by_path(params[:path]) if params[:path]
        unless @club.is_member?(current_user)
        flash[:danger] = "Only members can create posts."
        redirect_to build_club_path(@club)
        end
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
    
    
end
