class Public::SearchesController < ApplicationController
  def search
    @range = params[:range]
    @word = params[:word]
    @search = params[:search]

    if @range == "user"
      @records = User.where(is_active: true).search_for_name(@word, @search)
    elsif @range == "account_id"
      @records = User.where(is_active: true).search_for_account_id(@word, @search)
    else
      @records = Post.where(is_draft: false, is_hidden: false).search_for_post(@word, @search)
    end
  end
end
