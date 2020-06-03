require "minitest/autorun"
require "minitest/pride"
require "./lib/ingredient"
require "./lib/recipe"
require "./lib/pantry"

class PantryTest < MiniTest::Test

	def setup
    @ingredient1 = Ingredient.new({name: "Cheese", unit: "oz", calories: 50})
    @ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 200})
    @pantry = Pantry.new
	end

  def test_it_exists_with_attributes
    assert_instance_of Pantry, @pantry
    expected_stock = {}
    assert_equal expected_stock, @pantry.stock
  end

  def test_it_can_stock_ingredients
    assert_equal 0, @pantry.stock_check(@ingredient1)

    @pantry.restock(@ingredient1, 5)
    @pantry.restock(@ingredient1, 10)
    assert_equal 15, @pantry.stock_check(@ingredient1)

    @pantry.restock(@ingredient2, 7)
    assert_equal 7, @pantry.stock_check(@ingredient2)
  end

  def test_it_knows_if_it_has_enough_ingredients
    ingredient1 = Ingredient.new({name: "Cheese", unit: "C", calories: 100})
    ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 30})

    recipe1 = Recipe.new("Mac and Cheese")
    recipe1.add_ingredient(ingredient1, 2)
    recipe1.add_ingredient(ingredient2, 8)

    pantry = Pantry.new

    pantry.restock(ingredient1, 5)
    pantry.restock(ingredient1, 10)
    assert_equal false, pantry.enough_ingredients_for?(recipe1)

    pantry.restock(ingredient2, 7)
    assert_equal false, pantry.enough_ingredients_for?(recipe1)

    pantry.restock(ingredient2, 1)
    assert_equal true, pantry.enough_ingredients_for?(recipe1)
  end

end
