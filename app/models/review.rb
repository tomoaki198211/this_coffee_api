class Review < ApplicationRecord
  belongs_to :user
  belongs_to :coffee
  delegate :favorites, to: :coffee
  delegate :coffee_property, to: :coffee
  delegate :category, to: :coffee
  delegate :store, to: :coffee_property
end
