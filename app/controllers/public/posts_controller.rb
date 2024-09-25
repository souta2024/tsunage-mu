class Public::PostsController < ApplicationController
  def index
    @posts = Post.where(is_draft: false, is_hidden: false).order(published_at: :desc)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      if @post.is_draft == true
        redirect_to posts_draft_path
      else
        redirect_to timeline_path
      end
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
    @posts = Post.where(user_id: current_user.id, is_draft: false, is_hidden: false).order(created_at: :desc)
    @post = Post.new
  end

  def update_history
    @post = Post.find(params[:post_id])
    @post_histories = @post.post_histories.order(created_at: :desc)
  end

  def draft
    @posts = Post.where(user_id: current_user.id, is_draft: true, is_hidden: false).order(created_at: :desc)
    @post = Post.new
  end

  def edit_draft
    @post = Post.find(params[:id])
  end

  def update_draft
    @post = Post.find(params[:id])
    @post.update(post_params)
    if @post.is_draft == true
      redirect_to posts_draft_path
    else
      redirect_to timeline_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :is_draft)
  end
end
