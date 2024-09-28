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
end
