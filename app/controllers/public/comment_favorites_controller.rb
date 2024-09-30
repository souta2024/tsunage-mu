class Public::CommentFavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = Comment.find(params[:comment_id])
    favorite = current_user.comment_favorites.new(comment_id: comment.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    comment = Comment.find(params[:comment_id])
    favorite = current_user.comment_favorites.find_by(comment_id: comment.id)
    favorite.destroy
    redirect_to request.referer
  end

  private

  def ensure_guest_user
    comment = Comment.find(params[:comment_id])
    user = User.find_by(account_id: comment.user.account_id)
    if user.guest_user?
      flash[:alert] = "このページには遷移できません"
      redirect_to request.referer
    end
  end

  def is_matching_login_user
    comment = Comment.find(params[:comment_id])
    user = User.find_by(account_id: comment.user.account_id)
    unless user.id == current_user.id
      flash[:alert] = "このページには遷移できません"
      redirect_to request.referer
    end
  end
end
