class Coffee < ApplicationRecord
  belongs_to :coffee_property ,dependent: :destroy
  belongs_to :category
  has_many :reviews,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :users, through: :favorites
  delegate :store, to: :coffee_property

  validates :category_id, presence: true
  validates :coffee_property_id, presence: true

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
    where(category_id: category)
  end
end
