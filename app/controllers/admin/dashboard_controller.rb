class Admin::DashboardController < ApplicationController

  def index
    @lessons = Lesson.all.order_desc
  end
end
