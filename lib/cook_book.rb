require 'time'

class CookBook

  attr_reader :recipes, :date

  def initialize
    @recipes = []
    @date = get_date
  end

  def get_date
    date = Time.now.to_s
    date = date[0...10].split("-")
    "#{date[1]}-#{date[2]}-#{date[0]}"
  end

  def add_recipe(recipe)
    @recipes << recipe
  end

  def ingredients
    @recipes.reduce([]) do |names, recipe|
      ingredient_names = recipe.ingredients.map do |ingredient|
        ingredient.name
      end
      names << ingredient_names
      names
    end.flatten.uniq
  end

  def highest_calorie_meal
    @recipes.max_by do |recipe|
      recipe.total_calories
    end
  end

  def summary
    recipes.map do |recipe|
      recipe_name = recipe.name
      total_calories = recipe.total_calories
      ingredients = recipe.ingredients_required.map { |ingredient, amount| {ingredient: ingredient.name, amount: "#{amount} #{ingredient.unit}"} }
      ingredients = ingredients.sort_by { |ingredient_and_amount| ingredient_and_amount[:ingredient] }.reverse
      {name: recipe_name, details: { ingredients: ingredients, total_calories: total_calories}}
    end
  end

end
