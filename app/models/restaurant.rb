class Restaurant < ApplicationRecord

  validates :name, length: { minimum: 3 }

  has_many :reviews, dependent: :destroy
end
