class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = Comment.joins(:user).where(users: { is_active: true }).order(created_at: :desc).page(params[:page])
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "編集に成功しました。"
      redirect_to request.referer
    else
      flash.now[:alert] = "編集に失敗しました。"
      render :show
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:is_hidden)
  end
end
