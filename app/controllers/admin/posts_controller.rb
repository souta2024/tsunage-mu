class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.joins(:user).where(users: { is_active: true }, is_draft: false).order(published_at: :desc).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order(created_at: :desc).page(params[:page])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "編集に成功しました。"
      redirect_to admin_post_path(@post.id)
    else
      flash.now[:alert] = "編集に失敗しました。"
      render :show
    end
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
