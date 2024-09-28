class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit, :update, :destroy]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def edit
    @user = current_user
  end

  def show
    @user = User.find_by(account_id: params[:account_id])
    @user_posts = @user.posts.where(is_draft: false, is_hidden: false).order(published_at: :desc).page(params[:page])
    @user_comments = @user.comments.where(is_hidden: false).order(created_at: :desc).page(params[:page])

    @favorite_posts = PostFavorite.where(user_id: @user.id).order(created_at: :desc).map(&:post).select { |post| post.is_hidden == false }
    @favorite_posts = Kaminari.paginate_array(@favorite_posts).page(params[:page])

    @favorite_comments = CommentFavorite.where(user_id: @user.id).order(created_at: :desc).map(&:comment).select { |comment| comment.is_hidden == false }
    @favorite_comments = Kaminari.paginate_array(@favorite_comments).page(params[:page])

    @followings = @user.followings
    @follower_users = @user.followers
  end

  def update
    @user = User.find_by(account_id: params[:account_id])
    if @user.update(user_params)
      flash[:notice] = "編集に成功しました"
      redirect_to user_path(@user.account_id)
    else
      flash.now[:alert] = "編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @user = User.find_by(account_id: params[:account_id])
    if @user.update(is_active: false)
      sign_out(current_user)
      flash[:notice] = "退会に成功しました"
      redirect_to root_path
    else
      flash.now[:alert] = "退会に失敗しました。"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :account_id, :is_active)
  end

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
