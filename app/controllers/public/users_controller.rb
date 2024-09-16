class Public::UsersController < ApplicationController
  def index
  end

  def edit
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @user_posts = @user.posts
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_path(user.id)
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
