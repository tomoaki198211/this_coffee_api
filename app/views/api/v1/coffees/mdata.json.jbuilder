json.store do
  json.array! @stores do |store|
    json.partial! "api/v1/reviews/store", store: store
  end
end

json.category do
  json.array! @categories do |category|
    json.partial! "api/v1/reviews/category", category: category
  end
end
