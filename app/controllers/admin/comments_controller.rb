class Admin::CommentsController < ApplicationController
  def index
    @comments = Comment.all.order(publicshed_at: :desc)
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:is_hidden)
  end
end
