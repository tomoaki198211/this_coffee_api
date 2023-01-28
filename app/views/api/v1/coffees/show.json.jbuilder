##coffeeモデル(親)
json.coffee do
  json.partial! "api/v1/format/coffee", coffee: @coffee

    #コーヒープロパティモデル（子）
    json.coffee_property do
      json.partial! "api/v1/format/coffee_property", coffee_property: @coffee.coffee_property

      #店モデル（孫）
      json.store do
        json.partial! "api/v1/format/store", store: @coffee.store
      end
    end

  #カテゴリーモデル
  json.category do
    json.partial! "api/v1/format/category", category: @coffee.category
  end
end
