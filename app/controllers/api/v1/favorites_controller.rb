class Api::V1::FavoritesController < ApplicationController
  before_action :authenticate_api_v1_user!, only: %w(create destroy)

  def index
    @favorites = Favorite.filter_by_coffee(params[:coffee_id]).includes(:user, :coffee)
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

end
