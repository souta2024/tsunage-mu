class Admin::RelationshipsController < ApplicationController
  def followings
    user = User.find_by(account_id: params[:account_id])
    @users = user.followings.where(is_active: true)
  end

  def followers
    user = User.find_by(account_id: params[:account_id])
    @users = user.followers.where(is_active: true)
  end
end
