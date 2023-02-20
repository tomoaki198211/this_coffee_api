require 'rails_helper'

RSpec.describe "Api::V1::Reviews", type: :request do
  describe "GET /api/v1/reviews" do
    let!(:store){FactoryBot.create(:store)}
    let!(:category){FactoryBot.create(:category)}
    let!(:coffee_property){FactoryBot.create(:coffee_property)}
    let!(:coffee){FactoryBot.create(:coffee)}
    let!(:user){ FactoryBot.create(:user) }
    it "ユーザーが投稿したレビュー一覧が取得出来る" do
      auth_tokens = sign_in(user)
      get api_v1_reviews_path,headers: auth_tokens
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/reviews" do
    let!(:store){FactoryBot.create(:store)}
    let!(:category){FactoryBot.create(:category)}
    let!(:coffee_property){FactoryBot.create(:coffee_property)}
    let!(:coffee){FactoryBot.create(:coffee)}
    let!(:user){ FactoryBot.create(:user) }
    it "ユーザーがレビューを投稿出来る" do
      auth_tokens = sign_in(user)
      params={
          review: {
          coffee_id: coffee.id,
          intuition: 1,
          efficiency: 1,
          flavor: 1,
          sweetness: 1,
          rich: 1,
          acidity: 1,
          bitter: 1,
          remarks: "美味しかった",
          setting: true
          }
      }
      post api_v1_reviews_path, params: params, headers: auth_tokens
      expect(response).to have_http_status(201)
    end
  end

  describe "POST /api/v1/reviews/:id" do
    let!(:store){FactoryBot.create(:store)}
    let!(:category){FactoryBot.create(:category)}
    let!(:coffee_property){FactoryBot.create(:coffee_property)}
    let!(:coffee){FactoryBot.create(:coffee)}
    let!(:user){ FactoryBot.create(:user) }
    let!(:review){ FactoryBot.create(:review,user: user, coffee: coffee)}
    it "ユーザーがレビューを表示出来る" do
      get api_v1_review_path(review.id)
      expect(response).to have_http_status(200)
    end
  end

  describe "PUT /api/v1/reviews/:id" do
    let!(:store){FactoryBot.create(:store)}
    let!(:category){FactoryBot.create(:category)}
    let!(:coffee_property){FactoryBot.create(:coffee_property)}
    let!(:coffee){FactoryBot.create(:coffee)}
    let!(:user){ FactoryBot.create(:user) }
    let!(:review){ FactoryBot.create(:review,user: user, coffee: coffee)}
    it "ユーザーがレビューを更新出来る" do
      auth_tokens = sign_in(user)
      params={
        review: {
        coffee_id: coffee.id,
        intuition: 2,
        efficiency: 2,
        flavor: 2,
        sweetness: 2,
        rich: 2,
        acidity: 2,
        bitter: 2,
        remarks: "そうでもなかった",
        setting: true
        }
    }
      put api_v1_review_path(review.id), params: params, headers: auth_tokens
      expect(response).to have_http_status(201)
    end
  end

  describe "DELETE /api/v1/reviews/:id" do
    let!(:store){FactoryBot.create(:store)}
    let!(:category){FactoryBot.create(:category)}
    let!(:coffee_property){FactoryBot.create(:coffee_property)}
    let!(:coffee){FactoryBot.create(:coffee)}
    let!(:user){ FactoryBot.create(:user) }
    let!(:review){ FactoryBot.create(:review,user: user, coffee: coffee)}
    it "ユーザーがレビューを削除出来る" do
      auth_tokens = sign_in(user)
      delete api_v1_review_path(review.id), headers: auth_tokens
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/reviews/all" do
    it "全件レビューを表示する" do
      get all_api_v1_reviews_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/coffees/search" do
    let!(:store){FactoryBot.create(:store)}
    let!(:category){FactoryBot.create(:category)}
    let!(:coffee_property){FactoryBot.create(:coffee_property)}
    let!(:coffee){FactoryBot.create(:coffee)}
    it "レビューしたコーヒーの名前などで検索できる" do
      params = {
        search: {
          word: "スター",
        }
      }
      post search_api_v1_reviews_path, params: params
      expect(response).to have_http_status(200)
    end
  end
end
