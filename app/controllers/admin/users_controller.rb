class Admin::UsersController < ApplicationController
  def index
    @users = User.where.not(name: "guestuser")
  end

  def show
    @user = User.find_by(account_id: params[:account_id])
    @user_posts = @user.posts.where(is_draft: false).order(published_at: :desc)
    @user_comments = @user.comments.where(is_draft: false).order(published_at: :desc)
    @favorite_posts = PostFavorite.where(user_id: @user.id).order(published_at: :desc).map(&:post).select { |post| post.is_hidden == false }
    @favorite_comments = CommentFavorite.where(user_id: @user.id).order(published_at: :desc).map(&:comment).select { |post| post.is_hidden == false }
    @followings = @user.followings
    @follower_users = @user.followers
  end

  def edit

  end

  def update
    @user = User.find_by(account_id: params[:account_id])
    @user.update(user_params)
    redirect_to admin_user_path(@user.account_id)
  end

  private

  def user_params
    params.require(:user).permit(:is_active)
  end
end
