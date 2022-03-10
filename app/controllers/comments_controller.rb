class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @new_comment = current_user.comments.new(
      text: comment_params,
      user_id: current_user.id,
      post_id: @post.id
    )
    @new_comment.post_id = @post.id
    @new_comment.update_comments_counter
    if @new_comment.save
      redirect_to "/users/#{@post.user_id}/posts/#{@post.id}", flash: { alert: 'Posted Your Comment' }
    else
      flash.now[:error] = 'Failed to save comment'
      render action: 'new'
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    post = Post.find_by(id: @comment.post_id)
    post.comments_counter -= 1
    @comment.destroy!
    flash[:success] = 'You have deleted this comment!'
    redirect_to user_post_path(current_user.id, post.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)[:text]
  end
end
