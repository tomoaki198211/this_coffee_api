class Category < ApplicationRecord
  has_many :coffees

  validates :name, presence: true, length: { maximum: 30 }
end
