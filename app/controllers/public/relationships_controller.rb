class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:update, :destroy]
  before_action :is_matching_login_user, only: [:update, :destroy]

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

  private

    def ensure_guest_user
    user = User.find_by(account_id: params[:account_id])
    if user.guest_user?
      flash[:alert] = "このページには遷移できません"
      redirect_to request.referer
    end
  end

  def is_matching_login_user
    user = User.find_by(account_id: params[:account_id])
    unless user.id == current_user.id
      flash[:alert] = "このページには遷移できません"
      redirect_to request.referer
    end
  end
end
