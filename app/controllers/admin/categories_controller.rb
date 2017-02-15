class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource

  before_action :category_supports, only: :show

  def index
    @categories = Category.paginate page: params[:page],
      per_page: Settings.per_page_users
  end

  def new
    @category = Category.new
    render layout: false
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash.now[:success] = t "admin.create_new_category_success_msg"
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
    render layout: false
  end

  def update
    if @category.update_attributes category_params
      flash.now[:success] = t "admin.edit_category_success_message"
    end
    respond_to do |format|
      format.js
    end
  end

  def show
    @word = Word.new
    Settings.mininum_answers_count.times {@word.answers.build}
  end

  def destroy
    @category.destroy
    flash.now[:success] = t "admin.delete_category_success_message"
    respond_to do |format|
      format.js
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :duration, :word_per_lesson
  end

  def category_supports
    @support = Supports::Category_Support.new @category, params
  end
end
