class Coffee < ApplicationRecord
  belongs_to :coffee_property
  belongs_to :category
  has_many :reviews
  has_many :favorites
end
