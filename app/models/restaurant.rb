class Restaurant < ApplicationRecord

  validates :name, length: { minimum: 3 }, uniqueness: true

  def average_rating
    restaurant_reviews = Review.where(restaurant_id: self.id)
    puts restaurant_reviews
    if restaurant_reviews.length == 0
      return "No ratings yet for this restaurant"
    else
      restaurant_reviews.average(:rating)
    end
  end

  has_many :reviews, dependent: :destroy
  belongs_to :user
end
