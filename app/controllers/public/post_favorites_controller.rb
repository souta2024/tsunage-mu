class Public::PostFavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:update, :destroy]
  before_action :is_matching_login_user, only: [:update, :destroy]

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.post_favorites.new(post_id: post.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.post_favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to request.referer
  end

  private

  def ensure_guest_user
    post = Post.find(params[:post_id])
    user = User.find_by(account_id: post.user.account_id)
    if user.guest_user?
      flash[:alert] = "このページには遷移できません"
      redirect_to request.referer
    end
  end

  def is_matching_login_user
    post = Post.find(params[:post_id])
    user = User.find_by(account_id: post.user.account_id)
    unless user.id == current_user.id
      flash[:alert] = "このページには遷移できません"
      redirect_to request.referer
    end
  end
end
