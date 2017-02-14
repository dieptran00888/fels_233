class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = Category.all
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
    @words = @category.words
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
end
