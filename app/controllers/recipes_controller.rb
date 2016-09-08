class RecipesController < ApplicationController
  # GET /recipes
  def index
    if params[:page]
      @recipes = Recipe.published.page(params[:page][:number])
    else
      @recipes = Recipe.published.page
    end

    render json: @recipes, include: ['user', 'category']
  end
end
