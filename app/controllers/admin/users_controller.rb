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
    if @user.update(user_params)
      flash[:notice] = "編集に成功しました。"
      redirect_to admin_user_path(@user.account_id)
    else
      flash.now[:alert] = "編集に失敗しました。"
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:is_active)
  end
end
