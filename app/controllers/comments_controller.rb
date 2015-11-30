class CommentsController < ApplicationController
    before_action :logged_in_user
    before_action :authorized_member?, only: [:new, :create]
    
    
    # New acts as Reply
    def new
        @post = Post.find(params[:post_id]) 
        #@comment = @post.comments.build
        #@comment.parent_id = params[:parent_id]
    
        @comment = @post.comments.build(parent_id: params[:parent_id])
    end
    
    def create
        
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(comment_params)
        @comment.user = current_user
        
        if @comment.save
            redirect_to build_post_path(@post)
        else
            redirect_to build_post_path(@post)
        end
    end
    
    # unused method
    def index
        @post = Post.find(params[:post_id]) 
        @comments = @post.comments
    end
    
    def edit
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        
        unless @comment.is_owner?(current_user)
            redirect_to build_post_path(@post)
        end
    end
    
    def update
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        
        unless @comment.is_owner?(current_user)
            redirect_to build_post_path(@post) and return
        end
        
        if @comment.update(comment_params)
            flash[:success] = "Comment Updated!"
            redirect_to build_post_path(@post)
        else
            render 'edit'
        end
    end
    
    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @club = @post.club
        
        unless @comment.is_owner?(current_user) || @club.is_moderator?(current_user) 
            redirect_to build_post_path(@post) and return
        end
        
        @comment.destroy
        redirect_to build_post_path(@post)
    end
    
    private
    
    def comment_params
        params.require(:comment).permit(:comment, :parent_id)
    end
    
    def authorized_member?
        @post = Post.find(params[:post_id])
        @club = @post.club

        unless @club.is_member?(current_user)
            flash[:danger] = "Please become a member of this club to use this function."
            redirect_to build_post_path(@post)
        end
    end

end
