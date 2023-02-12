class Api::V1::CoffeesController < ApplicationController

  def index
    @coffees = Coffee.includes(:category,coffee_property: :store).order('id DESC')
  end

  def show
    set_coffee
  end

  def mdata
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
    @coffees ||= @coffees = Coffee.includes(:category,coffee_property: :store).order('id DESC').limit(10)
    render :index
  end

  def update
    @coffee_agg = CoffeeAggregation.new(coffee_aggrigation_params)
    @coffee_agg.update
  end

  private

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
