# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_is_active?, only: [:create]
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to timeline_path, notice: "ゲストログインしました。"
  end

  private

  def user_is_active?
    @user = User.find_by(email: params[:user][:email])
    return if !@user
    if @user.is_active == false
      flash[:alert] = "このアカウントは停止されています。"
      redirect_to new_user_registration_path
    else
      return
    end
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
