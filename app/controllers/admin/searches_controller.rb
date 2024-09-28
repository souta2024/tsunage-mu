class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @range = params[:range]
    @word = params[:word]
    @search = params[:search]

    if @range == "user"
      @records = User.where.not(name: "guestuser").search_for_name(@word, @search).order(created_at: :desc).page(params[:page])
    elsif @range == "account_id"
      @records = User.where.not(name: "guestuser").search_for_account_id(@word, @search).order(created_at: :desc).page(params[:page])
    else
      @records = Post.where(is_draft: false).search_for_post(@word, @search).order(published_at: :desc).page(params[:page])
    end
  end
end
