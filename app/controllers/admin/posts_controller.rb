class Admin::PostsController < ApplicationController
  def index
    @posts = Post.where(is_draft: false).order(publicshed_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to admin_post_path(@post.id)
  end

  def update_history
    @post = Post.find(params[:post_id])
    @post_histories = @post.post_histories.order(created_at: :desc)
  end

  private

  def post_params
    params.require(:post).permit(:is_hidden)
  end
end
