class Review < ApplicationRecord
  belongs_to :user
  belongs_to :coffee
  delegate :favorites, to: :coffee
  delegate :coffee_property, to: :coffee
  delegate :category, to: :coffee
  delegate :store, to: :coffee_property

  validates :intuition, :efficiency, :setting, presence: true
  validates :remarks, length: {maximum: 80}

  scope :search_word, -> (word) do
    next if word.blank?
    references(:coffee_properties).where('coffee_properties.name LIKE?', "%#{word}%")
  end

  scope :search_store, -> (store) do
    next if store.blank?
    where(store: {id: store})
  end

  scope :search_category, -> (category) do
    next if category.blank?
    where(category: {id: category})
  end
end
