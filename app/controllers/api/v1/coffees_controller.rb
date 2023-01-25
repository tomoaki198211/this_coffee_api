class Api::V1::CoffeesController < ApplicationController

  def index
    @coffees = Coffee.order('id DESC').limit(10)
  end

  def mdata
    @categories = Category.all
    @stores = Store.all
  end
end
