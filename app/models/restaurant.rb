class Restaurant < ApplicationRecord

  validates :name, length: { minimum: 3 }, uniqueness: true

  def average_rating
    Review.average("rating")
  end

  has_many :reviews, dependent: :destroy
  belongs_to :user
end
