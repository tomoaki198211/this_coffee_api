class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :coffee

  validates :user_id, presence: true
  validates :coffee_id, presence: true

  scope :filter_by_coffee, -> (coffee_id) {where(coffee_id: coffee_id) if coffee_id}
end
