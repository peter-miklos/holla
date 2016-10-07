class Restaurant < ApplicationRecord

  validates :name, length: { minimum: 3 }, uniqueness: true

  def average_rating
    restaurant_reviews = Review.where(restaurant_id: self.id)
    if restaurant_reviews.length == 0
      return "No ratings yet for this restaurant"
    else
      restaurant_reviews.average(:rating)
    end
  end

  def self.search(keyword)
   if keyword
     where("LOWER(name) LIKE ?", "%#{keyword.downcase}%")
   else
     find(:all)
   end
 end

  has_many :reviews, dependent: :destroy
  belongs_to :user
end
