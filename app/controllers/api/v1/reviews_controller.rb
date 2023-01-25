class Api::V1::ReviewsController < ApplicationController

  def index
    @reviews = Review.where(user_id: current_api_v1_user.id).includes(:user, coffee: [{coffee_property: :store}, :category, :favorites] )
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.save!
    # render :index, status: :ok
  end

  def show
    set_review
    # response_success(:review, :show)
    # render :show, status: :ok
    # render json: @review, include: [:user]
  end

  def edit
    set_review
  end

  def update
    if @review.update(review_params)
    else
    end
  end

  def destroy
    set_review

  end

  private

    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:coffee_id, :intuition, :efficiency, :flavor, :sweetness, :rich, :acidity, :bitter, :remarks, :setting).merge(user_id: current_api_v1_user.id)
    end
end
