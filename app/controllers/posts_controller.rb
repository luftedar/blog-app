class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
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
    @new_post = current_user.posts.new(params.require(:post).permit(:title, :text))
    @new_post.likes_counter = 0
    @new_post.comments_counter = 0
    @new_post.update_posts_counter
    respond_to do |_format|
      if @new_post.save
        redirect_to "/users/#{@new_post.user.id}/posts/", notice: 'Created Successfuly'
      else
        render :new, alert: 'Failed to Create!'
      end
    end
  end
end
