require 'rails_helper'

RSpec.describe 'コーヒアグリゲーション（activemodel）機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:store){FactoryBot.create(:store)}
    let!(:category){FactoryBot.create(:category)}
    let!(:coffee_property){FactoryBot.create(:coffee_property)}
    let!(:coffee){FactoryBot.create(:coffee)}

    context 'コーヒーアグリゲーションが全て入力されている場合' do
      it '登録成功する' do
        ca = CoffeeAggregation.new(coffee_id: coffee.id, store_id: store.id, category_id: category.id, property_id: coffee_property.id, coffee_name: coffee_property.name)
        expect(ca).to be_valid
      end
    end

    context 'コーヒーアグリゲーションでcoffeeのnameが足りていない場合' do
      it '登録失敗する' do
        ca = CoffeeAggregation.new(coffee_id: coffee.id, store_id: store.id, category_id: category.id, property_id: coffee_property.id)
        expect(ca).not_to be_valid
      end
    end
  end
end
