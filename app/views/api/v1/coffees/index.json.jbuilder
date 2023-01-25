##coffeeモデル(親)
json.array! @coffees do |coffee|
  json.extract! coffee,
  :id,
  :coffee_property_id,
  :category_id,
  :created_at,
  :updated_at

    #コーヒープロパティモデル（子）
    json.coffee_property do
      json.partial! "api/v1/reviews/coffee_property", coffee_property: coffee.coffee_property

      #店モデル（孫）
      json.store do
        json.partial! "api/v1/reviews/store", store: coffee.store
      end
    end

  #userモデル
  json.category do
    json.partial! "api/v1/reviews/category", category: coffee.category
  end
end
