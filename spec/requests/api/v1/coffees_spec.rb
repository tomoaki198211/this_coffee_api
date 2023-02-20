require 'rails_helper'

RSpec.describe "Api::V1::Coffees", type: :request do
  describe "GET /api/v1/coffees" do
    it "コーヒーを全件取得出来る" do
      get api_v1_coffees_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/coffees" do
    let!(:store){FactoryBot.create(:store)}
    let!(:category){FactoryBot.create(:category)}
    let!(:coffee_property){FactoryBot.create(:coffee_property)}
    let!(:user){ FactoryBot.create(:user) }

    it "コーヒーを作成出来る" do
      auth_tokens = sign_in(user)
      params = {
        coffee: {
          category_id: category.id,
          property_id: coffee_property.id,
          store_id: store.id,
          coffee_name: coffee_property.name
        }
      }
      post api_v1_coffees_path, params: params, headers: auth_tokens
      expect(response).to have_http_status :ok
    end
  end

  describe "PUT /api/v1/coffees/:id" do
    let!(:store){FactoryBot.create(:store)}
    let!(:category){FactoryBot.create(:category)}
    let!(:coffee_property){FactoryBot.create(:coffee_property)}
    let!(:coffee){FactoryBot.create(:coffee)}
    let!(:user){ FactoryBot.create(:user) }

    it "コーヒーの情報を更新出来る" do
      auth_tokens = sign_in(user)
      params = {
        coffee: {
          coffee_id: coffee.id,
          category_id: category.id,
          property_id: coffee_property.id,
          store_id: store.id,
          coffee_name: "爆弾コーヒー"
        }
      }
      put api_v1_coffee_path(coffee.id), params: params, headers: auth_tokens
      expect(response).to have_http_status :ok
    end
  end

  describe "DELETE /api/v1/coffees/:id" do
    let!(:store){FactoryBot.create(:store)}
    let!(:category){FactoryBot.create(:category)}
    let!(:coffee_property){FactoryBot.create(:coffee_property)}
    let!(:coffee){FactoryBot.create(:coffee)}
    let!(:user){ FactoryBot.create(:user) }

    it "コーヒーの情報を更新出来る" do
      auth_tokens = sign_in(user)
      params = {
        coffee: {
          coffee_id: coffee.id,
        }
      }
      delete api_v1_coffee_path(coffee.id), params: params, headers: auth_tokens
      expect(response).to have_http_status :ok
    end
  end

  describe "GET /api/v1/coffees/:id" do
    let!(:store){FactoryBot.create(:store)}
    let!(:category){FactoryBot.create(:category)}
    let!(:coffee_property){FactoryBot.create(:coffee_property)}
    let!(:coffee){FactoryBot.create(:coffee)}

    it "コーヒーの個別情報を閲覧出来る" do
      get api_v1_coffee_path(coffee.id)
      expect(response).to have_http_status :ok
    end
  end

  describe "GET /api/v1/coffees/option" do
    it "カテゴリなどのマスタを送信出来る" do
      get option_api_v1_coffees_path
      expect(response).to have_http_status :ok
    end
  end

  describe "POST /api/v1/coffees/search" do
    let!(:store){FactoryBot.create(:store)}
    let!(:category){FactoryBot.create(:category)}
    let!(:coffee_property){FactoryBot.create(:coffee_property)}
    let!(:coffee){FactoryBot.create(:coffee)}

    it "コーヒーの名前などで検索できる" do
      params = {
        search: {
          word: "スター",
        }
      }
      post search_api_v1_coffees_path, params: params
      expect(response).to have_http_status :ok
    end
  end

  describe "GET /api/v1/coffees/likes(" do
    let!(:store){FactoryBot.create(:store)}
    let!(:category){FactoryBot.create(:category)}
    let!(:coffee_property){FactoryBot.create(:coffee_property)}
    let!(:coffee){FactoryBot.create(:coffee)}
    let!(:user){ FactoryBot.create(:user) }

    it "ユーザーのお気に入りしているコーヒを返す" do
      auth_tokens = sign_in(user)
      get likes_api_v1_coffees_path, headers: auth_tokens
      expect(response).to have_http_status :ok
    end
  end

end
