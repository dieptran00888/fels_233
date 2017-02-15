class LessonsController < ApplicationController
  load_and_authorize_resource
  before_action :find_category, only: :create

  def create
    @lesson = @category.lessons.new user:current_user
    @lesson.save
    respond_to do |format|
      format.js
    end
  end

  def update
    if @lesson.finished?
      flash[:danger] = t "controllers.lessons.lesson_finished_error_message"
    else
      @lesson.assign_attributes lesson_params
      save_fields
      create_activity current_user.id, @lesson.id
    end
    redirect_to @lesson.category
  end

  def show
    @lesson.start_lesson if @lesson.init?
    @results = @lesson.results
  end

  private
  def lesson_params
    params.require(:lesson).permit :id, results_attributes: [:answer_id, :id]
  end

  def create_activity user_id, target_id
    Activity.create action_type: Activity.types[:finished_lesson],
      user_id: user_id, target_id: target_id
  end
  
  def find_category
    @category = Category.find_by id: params[:lesson][:category_id]
    unless @category
      flash.now[:danger] = t "controllers.lessons.category_not_found"
    end
  end
end
