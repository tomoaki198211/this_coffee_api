class Api::V1::ReviewsController < ApplicationController

  def index
    @reviews = Review.where(user_id: 23).includes(:user, coffee: [{coffee_property: :store}, :category, :favorites] )
    # @reviews = Review.where(user_id: 23)
  end

  def show
    set_review
  end

  private

    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:coffee_id, :intuition, :flavor, :sweetness, :rich, :acidity, :bitter, :remarks, :setting).merge(user: current_user)
    end
end
