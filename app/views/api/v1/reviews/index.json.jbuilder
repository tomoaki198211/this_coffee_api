##reviewモデル(親)
json.array! @reviews do |review|
  json.partial! "api/v1/format/review", review: review

##コーヒーモデル（子）
  json.coffee do
    json.partial! "api/v1/format/coffee", coffee: review.coffee

      json.category do
        json.partial! "api/v1/format/category", category: review.category
      end

      #コーヒープロパティモデル（孫）
      json.coffee_property do
        json.partial! "api/v1/format/coffee_property", coffee_property: review.coffee_property

        #店モデル（ひ孫）
        json.store do
          json.partial! "api/v1/format/store", store: review.store
        end
      end
  end

  #userモデル
  json.user do
    json.partial! "api/v1/format/user", user: review.user
  end
end
