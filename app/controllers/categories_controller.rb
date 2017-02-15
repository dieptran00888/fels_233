class CategoriesController < ApplicationController
  load_and_authorize_resource

  def show
    @support = Supports::Category_Support.new @category, params
  end
end
