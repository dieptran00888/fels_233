class CategoriesController < ApplicationController
  load_and_authorize_resource

  before_action :find_word, only: :show

  include CategoryUtils

  def index
    @search = Category.search params[:q]
    @categories = @search.result.paginate page: params[:page],
      per_page: Settings.per_page_users
    words_count
  end
  
  def show
    @support = Supports::Category_Support.new @category, params
  end
  
  private
  def find_word
    @words = if params[:search]
      Word.send(params[:filter], current_user.id, params[:id]).
        search(params[:search], params[:id]).send params[:select]
    else
      Word.search "", params[:id]
    end.paginate page: params[:page], per_page: Settings.per_page_users
  end
end
