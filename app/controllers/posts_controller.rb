class PostsController < ApplicationController
    
    before_action :logged_in_user, except: :show
    before_action :set_post, only: [:edit, :update, :destroy, :upvote]
    #before_action :correct_user, only: [:edit]
    before_action :authorized_member?, only: :new
    
    def new
        @club = nil
        @club = Club.by_path(params[:path]) if params[:path]
        @post = Post.new
    end
    
    def create
        #@club = Club.by_path(params[:post][:clubpath]) if params[:post][:clubpath]
        @club = Club.by_path(params[:club_path]) if params[:club_path]
        
        
        if @club.nil?
            flash[:danger] = 'ERROR: Could not find the specificed club'
            redirect_to root_path and return
        end
        
        unless @club.is_member?(current_user)
            flash[:danger] = "Only members can create posts."
            redirect_to build_club_path(@club) and return
        end
        
        
        @post = Post.new(post_params)
        @post.club_id = @club.id
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
    
    def edit
        if @post.nil?
            flash[:danger] = 'ERROR: Post does not exist'
            redirect_to root_path and return
        end
        
        @club = @post.club
        redirect_to build_post_path(@post) unless @post.is_owner?(current_user)
    end
    
    def update
        if @post.nil?
            flash[:danger] = 'ERROR: Post does not exist'
            redirect_to root_path and return
        end
        
        unless @post.is_owner?(current_user)
            redirect_to build_post_path(@post) and return
        end
        
        if @post.update(post_params)
            flash[:success] = "Post Updated!"
            redirect_to build_post_path(@post)
        else
          render :edit
        end
    end
     
    def destroy
        @club = @post.club
        unless @post.is_owner?(current_user) || @club.is_moderator?(current_user)
            flash[:danger] = "You are not the owner of this post."
            redirect_to build_club_path(@club) and return
        end
        @post.destroy
        flash[:success] = "Post deleted"
        redirect_to build_club_path(@post.club)
    end
    
    def upvote
        @post.upvote_by current_user
        @post.hotscore = @post.get_upvotes.size
        @post.save
        redirect_to :back
    end


    private
    
    def post_params
        params.require(:post).permit(:context, :title, :url, :club_id, :image, :picture, :option, :start_time)
    end
    
    def authorized_member?

        @club = Club.by_path(params[:path]) if params[:path]
        
        if @club.nil?
            flash[:danger] = "Unable to find the specified club" 
            redirect_to club_index_path
        end
        
        unless @club.is_member?(current_user)
            flash[:danger] = "Only members can create posts."
            redirect_to build_club_path(@club)
        end
    end

    # unused
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      
      redirect_to root_url if @post.nil?
    end
    
    def set_post
        @post = Post.find(params[:id])
    end
    
end
