require 'rails_helper'

RSpec.describe 'ストアモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'ストアのnameが空文字の場合' do
      it 'ストア登録失敗する' do
        store = Store.create(name: '')
        expect(store).not_to be_valid
      end
    end

    context 'ストアのnameが31文字以上の場合' do
      it 'ストア登録失敗する' do
        store = Store.create(name: 'aaaaaaaaaabbbbbbbbbbccccccccccc')
        expect(store).not_to be_valid
      end
    end

    context 'ストアのnameが入力されている場合' do
      it 'ストア登録成功する' do
        store = Store.create(name: '八百屋999')
        expect(store).to be_valid
      end
    end
  end
end
