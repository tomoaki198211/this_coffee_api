class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :coffee

  scope :filter_by_coffee, -> (coffee_id) {where(coffee_id: coffee_id) if coffee_id}
end
