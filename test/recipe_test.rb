require "minitest/autorun"
require "minitest/pride"
require "./lib/ingredient"
require "./lib/recipe"

class RecipeTest < MiniTest::Test

	def setup
    @ingredient1 = Ingredient.new({name: "Cheese", unit: "C", calories: 100})
    @ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 30})
    @recipe1 = Recipe.new("Mac and Cheese")
	end

  def test_it_exists_with_attributes
    assert_instance_of Recipe, @recipe1
    assert_equal "Mac and Cheese", @recipe1.name
    expected_ingredients_required = {}
    assert_equal expected_ingredients_required, @recipe1.ingredients_required
  end

  def test_it_knows_about_ingredients
    @recipe1.add_ingredient(@ingredient1, 2)
    @recipe1.add_ingredient(@ingredient1, 4)
    @recipe1.add_ingredient(@ingredient2, 8)

    expected_ingredients_required = {@ingredient1 => 6, @ingredient2 => 8}
    assert_equal expected_ingredients_required, @recipe1.ingredients_required

    assert_equal [@ingredient1, @ingredient2], @recipe1.ingredients
  end

  def test_it_knows_total_calories
    ingredient1 = Ingredient.new({name: "Cheese", unit: "C", calories: 100})
    ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 30})
    recipe1 = Recipe.new("Mac and Cheese")

    recipe1.add_ingredient(ingredient1, 2)
    recipe1.add_ingredient(ingredient2, 8)

    assert_equal 440, recipe1.total_calories


    ingredient3 = Ingredient.new({name: "Ground Beef", unit: "oz", calories: 100})
    ingredient4 = Ingredient.new({name: "Bun", unit: "g", calories: 75})
    recipe2 = Recipe.new("Cheese Burger")

    recipe2.add_ingredient(ingredient1, 2)
    recipe2.add_ingredient(ingredient3, 4)
    recipe2.add_ingredient(ingredient4, 1)

    assert_equal 675, recipe2.total_calories
  end


end
