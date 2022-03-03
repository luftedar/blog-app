class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @new_comment = current_user.comments.new(
      text: params.require(:comment).permit(:text)[:text],
      user_id: current_user.id,
      post_id: @post.id
    )
    @new_comment.post_id = @post.id
    @new_comment.update_comments_counter
    if @new_comment.save
      redirect_to "/users/#{@post.user_id}/posts/#{@post.id}", notice: 'Posted Success!'
    else
      render :new, alert: 'Failed to Post the Comment'
    end
  end
end
