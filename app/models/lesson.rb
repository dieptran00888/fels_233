class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :results, dependent: :destroy
  has_many :words, through: :results

  accepts_nested_attributes_for :results

  enum status: {init: 0, finished: 1, in_progress: 2}

  before_create :init_results

  scope :order_desc, -> {order created_at: :desc}

  def set_score
    score = 0
    results.each do |result|
      if result.answer.present? && result.answer.is_correct?
        score += 1
      end
    end
    assign_attributes score: score
  end

  def init_results
    self.words = category.words.order("RANDOM()").limit(category
      .word_per_lesson)
  end

  def start_lesson
    assign_attributes finish_time: Time.now + category.duration.minutes
    in_progress!
  end
end
