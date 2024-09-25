class Public::UsersController < ApplicationController
  def index
  end

  def edit
    @user = current_user
  end

  def show
    @user = User.find_by(account_id: params[:account_id])
    @user_posts = @user.posts.where(is_draft: false, is_hidden: false).order(published_at: :desc)
    @user_comments = @user.comments.where(is_draft: false, is_hidden: false).order(published_at: :desc)
    @favorite_posts = PostFavorite.where(user_id: @user.id).order(published_at: :desc).map(&:post).select { |post| post.is_draft == false && post.is_hidden == false }
    @favorite_comments = CommentFavorite.where(user_id: @user.id).order(published_at: :desc).map(&:comment).select { |post| post.is_hidden == false }
    @followings = @user.followings
    @follower_users = @user.followers
  end

  def update
    user = User.find_by(account_id: params[:account_id])
    if user.update(user_params)
      redirect_to user_path(account_id)
    else
      render :edit
    end
  end

  def destroy

  end

  def favorite

  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :is_active)
  end
end
