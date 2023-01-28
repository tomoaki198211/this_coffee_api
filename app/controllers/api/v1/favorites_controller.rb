class Api::V1::FavoritesController < ApplicationController

  def index
    @favorites = Favorite.filter_by_coffee(params[:coffee_id])
  end

  def create
    current_api_v1_user.favorites.create(favorite_params)
    head :created
  end

  def destroy
    current_api_v1_user.favorites.find(params[:id]).destroy!
    head :ok
  end

  private

  def favorite_params
    params.require(:favorite).permit(:coffee_id)
  end

  def favorite_params_id
    params.require(:favorite).permit(:id)
  end

end
