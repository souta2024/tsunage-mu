class Public::CommentsController < ApplicationController
  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.save
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    comment = Comment.find(params[:id])
    comment_history = CommentHistory.new
    comment_history.body = comment.body
    comment_history.comment_id = comment.id
    comment.update(comment_params)
    comment_history.edit_datetime = comment.updated_at
    comment_history.save
    redirect_to comment_path(comment.id)
  end

  def destroy

  end

  def update_history
    @comment_histories = CommentHistory.where(comment_id: params[:comment_id]).order(created_at: :DESC)
    @comment = Comment.find(params[:comment_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :is_draft, :user_id, :post_id)
  end
end
