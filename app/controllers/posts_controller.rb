class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @new_post = current_user.posts.new(post_params)
    @new_post.likes_counter = 0
    @new_post.comments_counter = 0
    @new_post.update_posts_counter
    respond_to do |format|
      format.html do
        if @new_post.save
          redirect_to "/users/#{@new_post.user.id}/posts/", flash: { alert: 'Posted new post' }
        else
          flash.now[:error] = 'Failed to create Post'
          render action: 'new'
        end
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    user = User.find(params[:user_id])
    user.posts_counter -= 1
    @post.destroy!
    user.save
    flash[:alert] = 'You have deleted this post!'
    redirect_to user_posts_path(user.id)
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
