class CommentsController < ApplicationController
    before_action :logged_in_user
    
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(comment_params)
        @comment.user = current_user
    
        if @comment.save
            redirect_to build_post_path(@post)
        else
            render 'new'
        end
    end
    
    private
    
    def comment_params
        params.require(:comment).permit(:comment)
    end
    
end
