class Public::UsersController < ApplicationController
  def index
  end

  def edit
    @user = current_user
  end

  def show
    @user = User.find(params[:id])

  end

  def update
    user = User.find(params[:id])
    @user.update(user_params)
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
