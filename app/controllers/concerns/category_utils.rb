module CategoryUtils
  extend ActiveSupport::Concern

  def words_count
    @words_count = Hash.new
    @categories.each do |category|
      @words_count[category.id] = category.words.
        learned_words(current_user.id, category.id).size
    end
  end
end