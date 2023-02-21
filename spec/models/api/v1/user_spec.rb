require 'rails_helper'

RSpec.describe 'ユーザーモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'ユーザーのemailが空文字の場合' do
      it 'ユーザー登録失敗する' do
        user = User.create(email: '', password: 'password', password_confirmation: 'password')
        expect(user).not_to be_valid
      end
    end

    context 'ユーザーのパスワードが空文字の場合' do
      it 'ユーザー登録失敗する' do
        user = User.create(email: 'sample1@test.com', password: '', password_confirmation: '')
        expect(user).not_to be_valid
      end
    end

    context 'ユーザーのemailとパスワードが入力されている場合' do
      it 'ユーザー登録成功する' do
        user = User.create(email: 'sample1@test.com', password: 'password', password_confirmation: 'password')
        expect(user).to be_valid
      end
    end
  end
end
