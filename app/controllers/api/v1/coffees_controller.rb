class Api::V1::CoffeesController < ApplicationController

  def index
    @coffees = Coffee.order('id DESC').limit(10)
  end
end
