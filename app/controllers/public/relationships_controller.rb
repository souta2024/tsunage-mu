class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find_by(account_id: params[:account_id])
    current_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = User.find_by(account_id: params[:account_id])
    current_user.unfollow(user)
    redirect_to request.referer
  end

  def followings
    user = User.find_by(account_id: params[:account_id])
    @users = user.followings.where(is_active: true).page(params[:page])
  end

  def followers
    user = User.find_by(account_id: params[:account_id])
    @users = user.followers.where(is_active: true).page(params[:page])
  end
end
