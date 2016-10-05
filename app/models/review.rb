class Review < ApplicationRecord
  validates :rating, inclusion: (1..5)

  belongs_to :user
  has_one :restaurant

  validates :user_id, uniqueness: { scope: :restaurant_id, message: "You have already reviewed this restaurant" }
  # validates_uniqueness_of :user_id, :scope => :restaurant_id, message: "You have already reviewed this restaurant"

end
