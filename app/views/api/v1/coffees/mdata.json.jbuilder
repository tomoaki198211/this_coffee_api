json.store do
  json.array! @stores do |store|
    json.extract! store,
    :id,
    :name,
    :created_at
  end
end
json.category do
  json.array! @categories do |category|
    json.extract! category,
    :id,
    :name,
    :created_at
  end
end
