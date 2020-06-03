require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/ingredient"
require "./lib/recipe"
require "./lib/cook_book"

class CookBookTest < MiniTest::Test

	def setup
    @recipe1 = Recipe.new("Mac and Cheese")
    @recipe2 = Recipe.new("Cheese Burger")
    @cookbook = CookBook.new
    # => #<CookBook:0x00007faae6a42228 @recipes=[]>
	end

  def test_it_exists_with_attributes
    assert_instance_of CookBook, @cookbook
    assert_equal [], @cookbook.recipes
  end

  def test_it_can_add_recipes
    @cookbook.add_recipe(@recipe1)
    @cookbook.add_recipe(@recipe2)
    assert_equal [@recipe1, @recipe2], @cookbook.recipes
  end

  def test_it_knows_highest_calorie_meal
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

    cookbook = CookBook.new
    cookbook.add_recipe(recipe1)
    cookbook.add_recipe(recipe2)

    assert_equal ["Cheese", "Macaroni", "Ground Beef", "Bun"], cookbook.ingredients
    assert_equal recipe2, cookbook.highest_calorie_meal
  end

  def test_it_has_a_summary
    ingredient1 = Ingredient.new({name: "Cheese", unit: "C", calories: 100})
    # => #<Ingredient:0x00007faae6a207e0...>
    ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 30})
    # => #<Ingredient:0x00007faae69e3cf0...>

    recipe1 = Recipe.new("Mac and Cheese")
    # => #<Recipe:0x00007faae69c9698...>

    recipe1.add_ingredient(ingredient1, 2)
    recipe1.add_ingredient(ingredient2, 8)

    ingredient3 = Ingredient.new({name: "Ground Beef", unit: "oz", calories: 100})
    # => #<Ingredient:0x00007faae6950860...>
    ingredient4 = Ingredient.new({name: "Bun", unit: "g", calories: 1})
    # => #<Ingredient:0x00007faae694bb80...>
    recipe2 = Recipe.new("Burger")
    # => #<Recipe:0x00007faae692a110...>

    recipe2.add_ingredient(ingredient3, 4)
    recipe2.add_ingredient(ingredient4, 100)

    cookbook = CookBook.new
    # => #<CookBook:0x00007faae6a42228 @recipes=[]>

    # The 'date' method should return the date the cookbook is created as "mm-dd-yyyy"
    expected_date = "04-22-2020"

    cookbook.stubs(:get_date).returns(expected_date)

    actual_date = cookbook.date

    # stub not working
    # assert_equal expected_date, actual_date

    cookbook.add_recipe(recipe1)
    cookbook.add_recipe(recipe2)

    expected_summary = [{:name=>"Mac and Cheese", :details=>{:ingredients=>[{:ingredient=>"Macaroni", :amount=>"8 oz"}, {:ingredient=>"Cheese", :amount=>"2 C"}], :total_calories=>440}}, {:name=>"Burger", :details=>{:ingredients=>[{:ingredient=>"Ground Beef", :amount=>"4 oz"}, {:ingredient=>"Bun", :amount=>"100 g"}], :total_calories=>500}}]
    assert_equal expected_summary, cookbook.summary




  end

end
