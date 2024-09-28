class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit, :update, :destroy]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def show
    @comment = Comment.find_by(id: params[:id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@comment.post.id)
    else
      @post = Post.find_by(id: @comment.post_id)
      @comments = @post.comments
      render 'public/posts/show'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    comment_history = CommentHistory.new
    comment_history.body = @comment.body
    comment_history.comment_id = @comment.id
    if @comment.update(comment_params)
      comment_history.edit_datetime = @comment.updated_at
      comment_history.save
      flash[:notice] = "編集に成功しました"
      redirect_to comment_path(@comment.id)
    else
      flash.now[:alert] = "編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = "削除に成功しました。"
      redirect_to post_path(@comment.post.id)
    else
      flash.now[:alert] = "削除に失敗しました。"
      render :show
    end
  end

  def update_history
    @comment_histories = CommentHistory.where(comment_id: params[:comment_id]).order(created_at: :DESC)
    @comment = Comment.find(params[:comment_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :is_draft, :user_id, :post_id)
  end

  def ensure_guest_user
    comment = Comment.find(params[:id])
    user = User.find_by(account_id: comment.user.account_id)
    if user.guest_user?
      flash[:alert] = "このページには遷移できません"
      redirect_to request.referer
    end
  end

  def is_matching_login_user
    comment = Comment.find(params[:id])
    user = User.find_by(account_id: comment.user.account_id)
    unless user.id == current_user.id
      flash[:alert] = "このページには遷移できません"
      redirect_to request.referer
    end
  end
end
