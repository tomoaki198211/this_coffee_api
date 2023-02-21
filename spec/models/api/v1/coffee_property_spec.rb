require 'rails_helper'

RSpec.describe 'コーヒープロパティモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:store){FactoryBot.create(:store)}

    context 'コーヒープロパティnameが空文字の場合' do
      it 'コーヒープロパティ登録失敗する' do
        coffee_property = CoffeeProperty.create(name: '', store_id: store.id)
        expect(coffee_property).not_to be_valid
      end
    end

    context 'コーヒープロパティnameが入力されている場合' do
      it 'コーヒープロパティ登録成功する' do
        coffee_property = CoffeeProperty.create(name: '抹茶イチゴオレ', store_id: store.id)
        expect(coffee_property).to be_valid
      end
    end
  end
end
