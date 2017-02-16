class StaticPagesController < ApplicationController
  before_action :load_data, :words_count
  def show
    if valid_page?
      render template: "static_pages/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  def index
    if user_signed_in?
      if current_user.is_admin?
        redirect_to admin_path
      end
    end
  end

  private
  def valid_page?
    File.exist? Pathname.new Rails.root +
      "app/views/static_pages/#{params[:page]}.html.erb"
  end
  def load_data
    @activities = Activity.all
    if user_signed_in?
      @courses = Category.ongoing_course current_user.id
      @learnt_words = Word.all_learned_words current_user
    end
  end
  def words_count
    if user_signed_in?
      @words_count = Hash.new
      Category.all.each do |category|
        @words_count[category.id] = category.words.
          learned_words(current_user.id, category.id).size
      end
    end
  end
end
