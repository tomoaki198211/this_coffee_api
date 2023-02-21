require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let!(:user){ FactoryBot.create(:user) }
  let!(:user2){ FactoryBot.create(:user2) }
  let!(:admin){ FactoryBot.create(:admin) }

  describe "GET /api/v1/admin/users" do
    it "管理権限ユーザーはユーザー情報を全件取得出来る" do
      auth_tokens = sign_in(admin)
      get api_v1_admin_users_path, headers: auth_tokens
      expect(response).to have_http_status :ok
    end

    it "一般権限ユーザーはユーザー情報を全件取得出来る" do
      auth_tokens = sign_in(user)
      get api_v1_admin_users_path, headers: auth_tokens
      expect(response).to have_http_status :unauthorized
    end
  end

  describe "PUT /api/v1/admin/users/:id" do
    it "管理権限ユーザーは他ユーザー情報を更新出来る" do
      auth_tokens = sign_in(admin)
      params={
          user: {
          name: "更新した",
          email: "user@example.com",
          password: "password"
        }
      }
      put api_v1_admin_user_path(user2.id), params: params, headers: auth_tokens
      expect(response).to have_http_status :ok
    end

    it "一般権限ユーザーは他ユーザー情報を更新出来ない" do
      auth_tokens = sign_in(user)
      params={
        user: {
        name: "更新した",
        email: "user@example.com",
        password: "password"
      }
    }
      put api_v1_admin_user_path(user2.id), params: params, headers: auth_tokens
      expect(response).to have_http_status :unauthorized
    end
  end

  describe "DELETE /api/v1/admin/users/:id" do
    it "管理権限ユーザーは他ユーザー情報を削除出来る" do
      auth_tokens = sign_in(admin)
      delete api_v1_admin_user_path(user2.id), headers: auth_tokens
      expect(response).to have_http_status :ok
    end

    it "一般権限ユーザーは他ユーザー情報を削除出来ない" do
      auth_tokens = sign_in(user)
      delete api_v1_admin_user_path(user2.id), headers: auth_tokens
      expect(response).to have_http_status :unauthorized
    end
  end
end
