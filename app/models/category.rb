class Category < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :words, dependent: :destroy

  validates :name, presence: true, length: {minimum: 3}
  validates :duration, presence: true, numericality: {only_integer: true}
  validates :word_per_lesson, presence: true, numericality: {only_integer: true}

  scope :ongoing_course, -> (user_id){joins(:lessons).
    where("lessons.user_id = ?", user_id).group("categories.id")}
end
