class Admin::WordsController < ApplicationController
  load_and_authorize_resource

  before_action :find_category, only: :create

  def create
    @word = Word.new word_params
    if @word.save
      flash.now[:success] = t "admin.create_new_word_success_msg"
      @new_word = Word.new
      Settings.mininum_answers_count.times {@new_word.answers.build}
    end
    respond_to do |format|
      format.js
    end
  end

  def update
    @word.update_attributes word_params
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @word.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def word_params
    params.require(:word).permit :category_id, :content,
      answers_attributes: [:is_correct, :content, :_destroy, :id]
  end

  def find_category
    @category = Category.find_by id: params[:word][:category_id]
    unless @category
      flash.now[:danger] = t "admin.category_not_found"
      redirect_to admin_categories_path
    end
  end
end
