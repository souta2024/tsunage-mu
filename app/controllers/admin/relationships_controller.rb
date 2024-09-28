class Admin::RelationshipsController < ApplicationController
  before_action :authenticate_admin!

  def followings
    user = User.find_by(account_id: params[:account_id])
    @users = user.followings.where(is_active: true).page(params[:page])
  end

  def followers
    user = User.find_by(account_id: params[:account_id])
    @users = user.followers.where(is_active: true).page(params[:page])
  end
end
