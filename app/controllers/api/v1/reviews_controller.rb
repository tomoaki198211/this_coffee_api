class Api::V1::ReviewsController < ApplicationController
  before_action :authenticate_api_v1_user!, only: %w(create update destroy)

  def index
    @reviews = Review.where(user_id: current_api_v1_user.id).preload(:user, coffee: [{coffee_property: :store}, :category, :favorites] ).limit(200)
  end

  def create
    @review = Review.new(review_params)
    if @review.save!
      head :created
    else
      head :bad_request
    end
  end

  def show
    set_review
  end

  def update
    set_review
    if @review.update!(review_params)
      head :created
    else
      head :bad_request
    end
  end

  def destroy
    set_review
    @review.destroy!
    head :ok
  end

  def all
    @reviews = Review.where(setting: true).includes(:user, coffee: [{coffee_property: :store}, :category, :favorites] ).limit(200)
    render :index
  end

  def search
    set_search_params
    unless @search[:word].blank? && @search[:category].blank? && @search[:store].blank?
      @reviews = Review.includes(:user, coffee: [{coffee_property: :store}, :category, :favorites])
                          .search_category(@search[:category])
                          .search_store(@search[:store])
                          .search_word(@search[:word])
    end
    @reviews ||= @reviews = Review.includes(:user,coffee: [{coffee_property: :store}, :category, :favorites]).limit(10)
    render :index
  end

  private

    def set_search_params
      @search = params.require(:search).permit(:word,:category,:store)
    end

    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:coffee_id, :intuition, :efficiency, :flavor, :sweetness, :rich, :acidity, :bitter, :remarks, :setting).merge(user_id: current_api_v1_user.id)
    end
end
