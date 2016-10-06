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

  # def average_rating
  #   restaurant_reviews = Review.where.(user_id: self.user_id).average
  #   restaurant_reviews
  # end
  #
  # def average_rating(restaurant_id)
  #   restaurant_ratings = Review.all(:select => "reviews.*,
  #                                   AVG(reviews.rating)
  #                                   WHERE reviews.user_id EQUALS #{user_id}"
  # end

  has_many :reviews, dependent: :destroy
  belongs_to :user
end
