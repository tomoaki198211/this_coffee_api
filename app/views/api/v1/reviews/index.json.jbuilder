json.array! @reviews do |review|
  json.extract! review,
    :id,
    :user_id,
    :coffee_id,
    :intuition,
    :efficiency,
    :flavor,
    :sweetness,
    :rich,
    :acidity,
    :bitter,
    :remarks,
    :setting,
    :created_at,
    :updated_at

##コーヒーモデル（子）
  json.coffee do
    json.extract! review.coffee,
      :id,
      :coffee_property_id,
      :category_id

      json.category do
        json.extract! review.category,
          :id,
          :name
      end

      #コーヒープロパティモデル（孫）
      json.coffee_property do
        json.extract! review.coffee_property,
          :id,
          :store_id,
          :name,
          :size,
          :price,
          :register_code,
          :image

        #店モデル（ひ孫）
        json.store do
          json.extract! review.store,
            :id,
            :name
        end
      end
  end
  json.user do
    json.extract! review.user,
      :id,
      :name,
      :email,
      :admin
  end
end
