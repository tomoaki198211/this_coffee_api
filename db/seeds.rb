require 'json'

size_starbucks = {
  "1" =>"ショート",
  "2" => "トール",
  "3" => "グランデ",
  "4" => "ベンティ"
}

users = [
  {email: "user1@example.com", password: "password",name: "user1"},
  {email: "user2@example.com", password: "password", name: "user2"},
]

# users.each do |user|
#   User.create!(
#     email: user[:email],
#     password: user[:password],
#     name: user[:name]
#   )
# end

categories = [{id: 1, name: "コーヒー(カフェ)"},
{id: 2, name: "コーヒー,COLD(カフェ)"},
{id: 3, name: "エスプレッソ(カフェ)"},
{id: 4, name: "ラテ(カフェ)"},
{id: 5, name: "フラペチーノ(カフェ)"},
{id: 6, name: "ティー(カフェ)"},
{id: 7, name: "その他(カフェ)"},
{id: 8, name: "コーヒー豆"},
{id: 9, name: "インスタントコーヒー"},
{id: 10, name: "缶"},
{id: 11, name: "その他"}
]

Store.create!(
  id:1, name:"スターバックス"
)

# カテゴリー作成
categories.each do |category|
  Category.create!(
    id: category[:id],
    name: category[:name]
  )
end


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
users = User.all
users = users.map{|user|user.id}
coffees = Coffee.all
coffees = coffees.map{|coffee|coffee.id}

10000.times{|n|
  Review.create!(
    user_id: users.sample,
    coffee_id: coffees.sample,
    intuition: rand(1..5),
    efficiency: rand(1..5),
    flavor: rand(1..5),
    sweetness: rand(1..5),
    rich: rand(1..5),
    acidity: rand(1..5),
    bitter: rand(1..5),
    setting: true,
    remarks: "これはサンプルで作成しました"
  )
}
# レビューの生成------------------
