class RecipesController < BlogsController
  # GET /recipes
  def index
    get_all_published_recipes

    render json: @blogs, include: ['user', 'category']
  end

  private

    def get_all_published_recipes
      if params[:page]
        @blogs = Blog.all_published_by_category('Recipe', current_user_id).page(params[:page][:number])
      else
        @blogs = Blog.all_published_by_category('Recipe', current_user_id).page
      end
    end
end
