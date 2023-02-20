class Api::V1::TweetsController < ApplicationController
  require 'json'
  require 'typhoeus'

  def search
    bearer_token = ENV['BEARER_TOKEN']
    search_url = "https://api.twitter.com/2/tweets/search/recent"
    query = coffee_params["name"]
    query = query.delete(' ')
    puts query
    query_params = {
      "query": query, # Required
      "max_results": 10,
      # "start_time": "2020-07-01T00:00:00Z",
      # "end_time": "2020-07-02T18:00:00Z",
      # "expansions": "attachments.poll_ids,attachments.media_keys,author_id",
      # "tweet.fields": "attachments,author_id,conversation_id,created_at,entities,id,lang",
      # "user.fields": "description"
      # "media.fields": "url",
      # "place.fields": "country_code",
      # "poll.fields": "options"
    }
    @response = get_tweet_counts(search_url, bearer_token, query_params)
    # puts @response.code, JSON.pretty_generate(JSON.parse(@response.body))
    render json: @response['data']
  end

  private

  def get_tweet_counts(url, bearer_token, query_params)
    options = {
      method: 'get',
      headers: {
        "User-Agent": "v2RecentTweetCountsRuby",
        "Authorization": "Bearer #{bearer_token}"
      },
      params: query_params
    }
      request = Typhoeus::Request.new(url, options)
      response = request.run
      if response.code == 200
        JSON.parse(response.body)
      else
        0
      end
    end

    def coffee_params
      params.require(:tweet).permit(:name)
    end
end
