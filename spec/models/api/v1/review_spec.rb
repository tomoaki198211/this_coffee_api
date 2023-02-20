require 'rails_helper'

RSpec.describe 'レビューモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:user){ FactoryBot.create(:user)}
    let!(:coffee){FactoryBot.create(:coffee)}

    context 'レビューのintuitionが空文字の場合' do
      it 'レビュー登録失敗する' do
        review = Review.create(intuition: '', efficiency: 2, remarks: 'そこそこ', setting: true, user_id: user.id, coffee_id: coffee.id)
        expect(review).not_to be_valid
      end
    end

    context 'レビューのefficiencyが空文字の場合' do
      it 'レビュー登録失敗する' do
        review = Review.create(intuition: 1, efficiency: '', remarks: 'そこそこ', setting: true, user_id: user.id, coffee_id: coffee.id)
        expect(review).not_to be_valid
      end
    end

    context 'レビューのremarksが空文字の場合' do
      it 'レビュー登録失敗する' do
        review = Review.create(intuition: 1, efficiency: 1, remarks: '', setting: true, user_id: user.id, coffee_id: coffee.id)
        expect(review).not_to be_valid
      end
    end

    context 'レビューのintuition,efficiency,remarksが入力されている場合' do
      it 'レビュー登録成功する' do
        review = Review.create(intuition: 1, efficiency: 2, remarks: 'そこそこ', setting: true, user_id: user.id, coffee_id: coffee.id)
        expect(review).to be_valid
      end
    end
  end
end
