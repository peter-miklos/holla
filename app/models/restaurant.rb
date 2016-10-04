class Restaurant < ApplicationRecord

  validates :name, length: { minimum: 3 }, uniqueness: true

  has_many :reviews, dependent: :destroy
end
