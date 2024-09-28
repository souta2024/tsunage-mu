class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit, :update, :destroy, :show_draft, :edit_draft, :update_draft]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy, :show_draft, :edit_draft, :update_draft]

  def index
    @post = Post.new
    # 有効な投稿を全て表示
    @posts = Post.joins(:user).where(users: { is_active: true }, is_draft: false, is_hidden: false).order(published_at: :desc).page(params[:page])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      if @post.is_draft == true
        flash[:notice] = "下書きの作成に成功しました。"
        redirect_to posts_drafts_path
      else
        flash[:notice] = "投稿に成功しました。"
        redirect_to timeline_path
      end
    else
      flash.now[:alert] = "投稿に失敗しました。"
      if render_path_params["render_path"] == "/posts/drafts"
        @posts = Post.where(user_id: current_user.id, is_draft: true, is_hidden: false).order(created_at: :desc)
        render :drafts
      elsif render_path_params["render_path"] == "/timeline"
        @posts = @posts = Post.where(user_id: [current_user.id] + current_user.followings.pluck(:id), is_draft: false, is_hidden: false).order(published_at: :desc)
        render :timeline
      else
        @posts = Post.where(is_draft: false, is_hidden: false).order(published_at: :desc)
        render :index
      end
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @comments = @post.comments.joins(:user).where(users: { is_active: true }, is_hidden: false).order(created_at: :desc).page(params[:page])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    post_history = PostHistory.new
    post_history.body = @post.body
    post_history.post_id = @post.id
    if @post.update(post_params)
      flash[:notice] = "編集に成功しました。"
      post_history.edit_datetime = @post.updated_at
      post_history.save
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = "編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "削除に成功しました。"
      redirect_to posts_path
    else
      flash.now[:alert] = "削除に失敗しました。"
      render :show
    end
  end

  def timeline
    @post = Post.new
    # ログインユーザーとフォローしているユーザーの投稿を表示
    current_user_posts = current_user.posts.where(is_draft: false, is_hidden: false)
    followed_users_posts = Post.joins(user: :followers).where(users: { is_active: true }, relationships: { follower_id: current_user.id }).where(is_draft: false, is_hidden: false)
    @posts = current_user_posts + followed_users_posts
    @posts = (current_user_posts + followed_users_posts).sort_by {|post| post.published_at}.reverse
    @posts = Kaminari.paginate_array(@posts).page(params[:page])
  end

  def update_history
    @post = Post.find(params[:post_id])
    @post_histories = @post.post_histories.order(created_at: :desc).page(params[:page])
  end

  def drafts
    @posts = Post.where(user_id: current_user.id, is_draft: true, is_hidden: false).order(created_at: :desc).page(params[:page])
    @post = Post.new
  end

  def show_draft
    @post = Post.find(params[:id])
  end

  def edit_draft
    @post = Post.find(params[:id])
  end

  def update_draft
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "編集に成功しました。"
      if @post.is_draft == true
        redirect_to posts_drafts_path
      else
        redirect_to timeline_path
      end
    else
      flash.now[:alert] = "編集に失敗しました。"
      render :edit_draft
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :is_draft)
  end

  def render_path_params
    params.require(:post).permit(:render_path)
  end

  def ensure_guest_user
    post = Post.find(params[:id])
    user = User.find_by(account_id: post.user.account_id)
    if user.guest_user?
      flash[:alert] = "このページには遷移できません"
      redirect_to request.referer
    end
  end

  def is_matching_login_user
    post = Post.find(params[:id])
    user = User.find_by(account_id: post.user.account_id)
    unless user.id == current_user.id
      flash[:alert] = "このページには遷移できません"
      redirect_to request.referer
    end
  end

end
