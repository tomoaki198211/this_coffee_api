class Api::V1::CoffeesController < ApplicationController
  before_action :authenticate_api_v1_user!, only: %w(create update destroy)
  def index
    @coffees = Coffee.includes(:category,coffee_property: :store).order('id DESC')
  end

  def create
    coffee_agg = CoffeeAggregation.new(coffee_aggrigation_params)
    if coffee_agg.save
      head :ok
    else
      head :bad_request
    end
  end

  def show
    set_coffee
    get_review_info
  end

  def update
    coffee_agg = CoffeeAggregation.new(coffee_aggrigation_params)
    if coffee_agg.update
      head :ok
    else
      head :bad_request
    end
  end

  def destroy
    set_coffee
    @coffee.destroy!
    head :ok
  end

  def option
    @categories = Category.all
    @stores = Store.all
  end

  def search
    set_search_params
    unless @search[:word].blank? && @search[:category].blank? && @search[:store].blank?
      @coffees = Coffee.includes(coffee_property: :store)
                          .search_category(@search[:category])
                          .search_store(@search[:store])
                          .search_word(@search[:word])
    end
    @coffees ||= @coffees = Coffee.includes(:category,coffee_property: :store).order('id DESC')
    render :index
  end

  def likes
    @coffees = current_api_v1_user.coffees.includes(:category,coffee_property: :store)
    render :index
  end

  private

    def review_avg_calc(array)
      array.sum.fdiv(array.length)
    end

    def get_review_info
      @reviews = @coffee.reviews
      intuition = @reviews.where("intuition > ?",0).pluck(:intuition)
      efficiency = @reviews.where("efficiency > ?",0).pluck(:efficiency)
      flavor = @reviews.where("flavor > ?",0).pluck(:flavor)
      sweetness = @reviews.where("sweetness > ?",0).pluck(:flavor)
      rich = @reviews.where("rich > ?",0).pluck(:flavor)
      acidity = @reviews.where("acidity > ?",0).pluck(:flavor)
      bitter = @reviews.where("bitter > ?",0).pluck(:flavor)

      @count = @coffee.reviews.length
      @favorites = @coffee.favorites.length
      @intuition = review_avg_calc(intuition)
      @efficiency = review_avg_calc(efficiency)
      @flavor = review_avg_calc(flavor)
      @sweetness = review_avg_calc(sweetness)
      @rich = review_avg_calc(rich)
      @acidity = review_avg_calc(acidity)
      @bitter = review_avg_calc(bitter)
    end

    def coffee_aggrigation_params
      params.require(:coffee).permit(:coffee_id, :store_id, :category_id,
                                     :property_id, :coffee_name, :size, :price, :note)
    end

    def set_coffee
      @coffee = Coffee.find(params[:id])
    end

    def set_search_params
      @search = params.require(:search).permit(:word,:category,:store)
    end

end
