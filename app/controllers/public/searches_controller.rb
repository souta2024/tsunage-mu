class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]
    @search = params[:search]

    if @range == "user"
      @records = User.where(is_active: true).where.not(name: "guestuser").search_for_name(@word, @search).order(created_at: :desc).page(params[:page]).per(1)
    elsif @range == "account_id"
      @records = User.where(is_active: true).where.not(name: "guestuser").search_for_account_id(@word, @search).order(created_at: :desc).page(params[:page]).per(1)
    else
      @records = Post.where(is_draft: false, is_hidden: false).search_for_post(@word, @search).order(published_at: :desc).page(params[:page]).per(1)
    end
  end
end
