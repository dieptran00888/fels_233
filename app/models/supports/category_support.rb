class Supports::Category_Support
  attr_reader :category

  def initialize category, params
    @category = category
    @params = params
  end

  def lessons
    @lessons = @category.lessons.order_desc
  end

  def lesson
    @lesson = Lesson.new
  end

  def words
    @words = @category.words.paginate page: @params[:page],
      per_page: Settings.per_page_users
  end
end
