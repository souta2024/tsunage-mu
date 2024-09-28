class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.where.not(name: "guestuser").order(created_at: :desc).page(params[:page])
  end

  def show
    @user = User.find_by(account_id: params[:account_id])
    @user_posts = @user.posts.where(is_draft: false).order(published_at: :desc).page(params[:page])
    @user_comments = @user.comments.order(created_at: :desc).page(params[:page])

    @favorite_posts = PostFavorite.where(user_id: @user.id).order(created_at: :desc).map(&:post).select { |post| post.is_hidden == false }
    @favorite_posts = Kaminari.paginate_array(@favorite_posts).page(params[:page])

    @favorite_comments = CommentFavorite.where(user_id: @user.id).order(created_at: :desc).map(&:comment).select { |comment| comment.is_hidden == false }
    @favorite_comments = Kaminari.paginate_array(@favorite_comments).page(params[:page])

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
