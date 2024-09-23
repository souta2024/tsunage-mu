class Public::PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :DESC)
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      redirect_to post_path(post.id)
    else
      redirect_to root_path
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post_history = PostHistory.new
    post_history.body = post.body
    post_history.post_id = post.id
    post.update(post_params)
    post_history.edit_datetime = post.updated_at
    post_history.save
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def timeline

  end

  def draft

  end

  def update_history
    @post = Post.find(params[:post_id])
    @post_histories = @post.post_histories.order(created_at: :DESC)
  end

  private

  def post_params
    params.require(:post).permit(:body, :is_draft)
  end
end
