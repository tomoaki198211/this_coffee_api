class Api::V1::ReviewsController < ApplicationController
  def index
    @reviews = Review.where(user_id: 23).includes([:user, coffee: :coffee_property, coffee: :category])
  end
end
