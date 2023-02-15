json.array! @coffees do |coffee|
  json.partial! "api/v1/format/coffee", coffee: coffee
end
