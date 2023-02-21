class Review < ApplicationRecord
  belongs_to :user
  belongs_to :coffee
  delegate :favorites, to: :coffee
  delegate :coffee_property, to: :coffee
  delegate :category, to: :coffee
  delegate :store, to: :coffee_property

  validates :intuition, :efficiency, presence: true
  validates :setting, inclusion: [true, false]
  validates :remarks, presence: true, length: {maximum: 80}

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

  #各レビューが有効な物を配列で返す
  scope :intuition_extract, -> {
    where("intuition > ?",0).pluck(:intuition)
  }

  scope :efficiency_extract, -> {
    where("efficiency > ?",0).pluck(:efficiency)
  }

  scope :flavor_extract, -> {
    where("flavor > ?",0).pluck(:flavor)
  }

  scope :sweetness_extract, -> {
    where("sweetness > ?",0).pluck(:sweetness)
  }

  scope :rich_extract, -> {
    where("rich > ?",0).pluck(:rich)
  }

  scope :bitter_extract, -> {
    where("bitter > ?",0).pluck(:bitter)
  }

  scope :acidity_extract, -> {
    where("acidity > ?",0).pluck(:acidity)
  }

  #好みで星５評価を配列で取得
  scope :preference_extract, -> (preference) do
    case preference.to_i
    when 1 then
      flavor_max_extract.order('created_at DESC')
    when 2 then
      sweetness_max_extract.order('created_at DESC')
    when 3 then
      acidity_max_extract.order('created_at DESC')
    when 4 then
      rich_max_extract.order('created_at DESC')
    when 5 then
      bitter_max_extract.order('created_at DESC')
    end
  end

  scope :flavor_max_extract, -> {
    where(flavor: 5)
  }

  scope :sweetness_max_extract, -> {
    where(sweetness: 5)
  }

  scope :rich_max_extract, -> {
    where(rich: 5)
  }

  scope :bitter_max_extract, -> {
    where(bitter: 5)
  }

  scope :acidity_max_extract, -> {
    where(acidity: 5)
  }
end
