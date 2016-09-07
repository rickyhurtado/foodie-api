class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  # GET /recipes
  def index
    if params[:page]
      @recipes = Recipe.published.page(params[:page][:number])
    else
      @recipes = Recipe.published.page
    end

    render json: @recipes, include: ['user', 'category']
  end

  # GET /recipe/1
  def show
    render json: @recipe
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Blog.find(params[:id])
    end
end
