class CoffeeProperty < ApplicationRecord
  belongs_to :store
  has_many :coffees

  validates :name, presence: true
end
