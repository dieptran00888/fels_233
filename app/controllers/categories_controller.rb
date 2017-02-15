class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @search = Category.search params[:q]
    @categories = @search.result.paginate page: params[:page],
      per_page: Settings.per_page_users
  end
  
  def show
    @support = Supports::Category_Support.new @category, params
  end
end
