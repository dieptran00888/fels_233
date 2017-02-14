class CategoriesController < ApplicationController
  load_and_authorize_resource

  def show
    @support = Supports::Category.new @category
  end
end
