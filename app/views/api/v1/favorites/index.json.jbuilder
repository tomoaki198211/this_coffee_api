##favoriteモデル
json.array! @favorites do |favorite|
  json.partial! "api/v1/format/favorite", favorite: favorite
end
