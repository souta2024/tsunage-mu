class Public::CommentsController < ApplicationController
  def show
  end

  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    if comment.save
      redirect_to post_path(comment.post.id)
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def update

  end

  def destroy

  end

  def update_history
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :body, :is_draft)
  end
end
