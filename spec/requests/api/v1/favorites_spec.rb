require 'rails_helper'

RSpec.describe "Api::V1::Favorites", type: :request do
  let!(:store){FactoryBot.create(:store)}
  let!(:category){FactoryBot.create(:category)}
  let!(:coffee_property){FactoryBot.create(:coffee_property)}
  let!(:coffee){FactoryBot.create(:coffee)}
  let!(:user){ FactoryBot.create(:user) }

  describe "GET /api/v1/coffees/:coffee_id/favorites" do
    it "コーヒーに基づくお気に入りを返す" do
      get api_v1_coffee_favorites_path(coffee.id)
      expect(response).to have_http_status :ok
    end
  end

  describe "POST /api/v1/coffees/:coffee_id/favorites" do
    it "ユーザーが対象のコーヒーにお気に入りを出来る" do
      auth_tokens = sign_in(user)
      params={
        favorite:{
          coffee_id: coffee.id
        }
      }
      post api_v1_coffee_favorites_path(coffee.id), params: params, headers: auth_tokens
      expect(response).to have_http_status :created
    end
  end

  describe "DELETE /api/v1/coffees/:coffee_id/favorites/:id" do
    let!(:favorite){FactoryBot.create(:favorite, user: user, coffee: coffee)}
    it "ユーザーが対象のコーヒーにお気に入りを解除出来る" do
      auth_tokens = sign_in(user)
      delete api_v1_coffee_favorite_path(coffee.id,favorite.id), headers: auth_tokens
      expect(response).to have_http_status :ok
    end
  end
end
