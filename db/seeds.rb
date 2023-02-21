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
  {email: "user3@example.com", password: "password", name: "user3"},
  {email: "user4@example.com", password: "password", name: "user4"},
  {email: "user5@example.com", password: "password", name: "user5"},
]

users.each do |user|
  User.create!(
    email: user[:email],
    password: user[:password],
    name: user[:name]
  )
end

categories = [{id: 1, name: "コーヒー(カフェ)"},
{id: 2, name: "コーヒーコールド(カフェ)"},
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

stores = [{id: 1, name: "スターバックスコーヒー"},
  {id: 2, name: "ドトールコーヒー"},
  {id: 3, name: "タリーズコーヒー"},
  {id: 4, name: "コメダ珈琲店"},
  {id: 5, name: "星乃珈琲店"},
  {id: 6, name: "サンマルクカフェ"},
  {id: 7, name: "上島珈琲店"},
  {id: 8, name: "エクセルシオールカフェ"},
  {id: 9, name: "カフェ・ベローチェ"},
  {id: 10, name: "珈琲館"},
  {id: 11, name: "プロント"},
  {id: 12, name: "倉式珈琲店"},
  {id: 13, name: "ホノルルコーヒー"},
  {id: 14, name: "ディーン・アンド・デルーカ"},
  {id: 15, name: "猿田彦珈琲"},
  {id: 16, name: "ベックスコーヒー"},
  {id: 17, name: "高倉珈琲"},
  {id: 18, name: "グリーンベリーズコーヒー"},
  {id: 19, name: "イリーカフェ"},
  {id: 20, name: "ブルーボトルコーヒー"},
  {id: 21, name: "カルディコーヒー"},
  {id: 22, name: "ローソン"},
  {id: 23, name: "ファミリーマート"},
  {id: 24, name: "セブンイレブン"},
  {id: 25, name: "その他"},
  ]

# ストア作成
stores.each do |store|
  Store.create!(
    id: store[:id],
    name: store[:name]
  )
end

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
    cp.name = coffee["product_name"].gsub(/&\w*;/,'')
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
