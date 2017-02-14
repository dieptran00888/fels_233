class Supports::Category
  attr_reader :category

  def initialize category
    @category = category
  end

  def lessons
    @lessons = @category.lessons.order_desc
  end

  def lesson
    @lesson = Lesson.new
  end
end
