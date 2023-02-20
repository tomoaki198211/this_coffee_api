class Store < ApplicationRecord
  has_many :coffee_properties

  validates :name, presence: true, length: { maximum: 30 }
end
