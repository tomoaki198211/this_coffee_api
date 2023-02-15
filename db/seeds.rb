require 'json'

size_starbucks = {
  "1" =>"ショート",
  "2" => "トール",
  "3" => "グランデ",
  "4" => "ベンティ"
}

Category.create(
)

# スターバックス用json読み込みからコーヒープロパティ生成-----------
coffees = ActiveSupport::JSON.decode(File.read(Rails.root.join('db', 'index.json')))
coffees.each do |coffee|
  CoffeeProperty.find_or_create_by(register_code: coffee["product_code"]) do |cp|
    cp.store_id = 1
    cp.name = coffee["product_name"]
    cp.price = coffee["price"]
    cp.image = coffee["image1"]
    cp.size = size_starbucks[coffee["size"]]
  end
end
coffee_properties = CoffeeProperty.all
coffee_properties.each do |property|
  Coffee.find_or_create_by(coffee_property_id: property.id) do |coffee|
    coffee.category_id = 1
    coffee.coffee_property_id = property.id
  end
end
# スターバックス用json読み込みからコーヒープロパティ生成-----------


# レビューの生成------------------
# users = User.all
# users = users.map{|user|user.id}
# coffees = Coffee.all
# coffees = coffees.map{|coffee|coffee.id}

# 100.times{|n|
#   Review.create!(
#     user_id: users.sample,
#     coffee_id: coffees.sample,
#     intuition: rand(1..5),
#     efficiency: rand(1..5),
#     flavor: rand(1..5),
#     sweetness: rand(1..5),
#     rich: rand(1..5),
#     acidity: rand(1..5),
#     bitter: rand(1..5),
#     setting: true,
#     remarks: "これはサンプルで作成"
#   )
# }
# レビューの生成------------------
