json.store do
  json.array! @stores do |store|
    json.partial! "api/v1/format/store", store: store
  end
end

json.category do
  json.array! @categories do |category|
    json.partial! "api/v1/format/category", category: category
  end
end
