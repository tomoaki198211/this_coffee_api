require 'rails_helper'

RSpec.describe 'カテゴリーモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'カテゴリーのnameが空文字の場合' do
      it 'カテゴリー登録失敗する' do
        category = Category.create(name: '')
        expect(category).not_to be_valid
      end
    end

    context 'カテゴリーのnameが31文字以上の場合' do
      it 'カテゴリー登録失敗する' do
        category = Category.create(name: 'aaaaaaaaaabbbbbbbbbbccccccccccc')
        expect(category).not_to be_valid
      end
    end

    context 'カテゴリーのnameが入力されている場合' do
      it 'カテゴリー登録成功する' do
        category = Category.create(name: 'ココア')
        expect(category).to be_valid
      end
    end
  end
end
