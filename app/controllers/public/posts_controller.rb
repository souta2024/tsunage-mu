class Public::PostsController < ApplicationController
  def index
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      redirect_to post_path(post.id)
    else
      redirect_to root_path
    end
  end

  def show
  end

  def edit
  end

  def update

  end

  def destroy

  end

  def update_history
  end

  private

  def post_params
    params.require(:post).permit(:body, :is_active)
  end
end
