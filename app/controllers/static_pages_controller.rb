class StaticPagesController < ApplicationController
  before_action :load_data
  def show
    if valid_page?
      render template: "static_pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist? Pathname.new Rails.root +
      "app/views/static_pages/#{params[:page]}.html.erb"
  end
  def load_data
    @activities = Activity.all
  end
end
