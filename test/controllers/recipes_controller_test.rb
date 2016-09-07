require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recipe = blogs(:blog_2)
  end

  test "should get index" do
    get recipes_url, as: :json
    assert_response :success
  end

  test "should show recipe" do
    get recipe_url(@recipe), params: { id: @recipe.id }, as: :json
    assert_response :success
  end
end
