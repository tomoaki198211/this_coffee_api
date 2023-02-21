require 'rails_helper'

RSpec.describe 'レビューモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    let!(:user){ FactoryBot.create(:user)}
    let!(:coffee){FactoryBot.create(:coffee)}

    context 'レビューのintuitionがない場合' do
      it 'レビュー登録失敗する' do
        review = Review.create(intuition: nil, efficiency: 2, remarks: 'そこそこ', setting: true, user_id: user.id, coffee_id: coffee.id)
        expect(review).not_to be_valid
      end
    end

    context 'レビューのefficiencyがない場合' do
      it 'レビュー登録失敗する' do
        review = Review.create(intuition: 1, efficiency: nil, remarks: 'そこそこ', setting: true, user_id: user.id, coffee_id: coffee.id)
        expect(review).not_to be_valid
      end
    end

    context 'レビューのremarksがない場合' do
      it 'レビュー登録失敗する' do
        review = Review.create(intuition: 1, efficiency: 1, remarks: nil, setting: true, user_id: user.id, coffee_id: coffee.id)
        expect(review).not_to be_valid
      end
    end

    context 'レビューのremarksが81文字以上の場合' do
      it 'レビュー登録失敗する' do
        review = Review.create(intuition: 1, efficiency: 1, remarks: 'aaaaaaaaaabbbbbbbbbbaaaaaaaaaabbbbbbbbbbaaaaaaaaaabbbbbbbbbbaaaaaaaaaabbbbbbbbbbaaaaaaaaaabbbbbbbbbb', setting: true, user_id: user.id, coffee_id: coffee.id)
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
