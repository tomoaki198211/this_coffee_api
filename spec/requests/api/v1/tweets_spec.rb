# require 'rails_helper'

# RSpec.describe "Api::V1::Tweets", type: :request do
#   describe "POST /api/v1/tweets/search" do
#     let!(:user){ FactoryBot.create(:user) }
#     it "twitter APIを検索する事が出来る" do
#       auth_tokens = sign_in(user)
#       params = {
#         tweet: {
#           name: "抹茶"
#         }
#       }
#       post api_v1_tweets_search_path, params: params, headers: auth_tokens
#       expect(response).to have_http_status(200)
#     end
#   end
# end
