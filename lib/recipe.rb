class Recipe

  attr_reader :name, :ingredients_required

  def initialize(name)
    @name = name
    @ingredients_required = {}
    @ingredients_required.default = 0
  end

  def add_ingredient(ingredient, amount)
    @ingredients_required[ingredient] += amount
  end

  def ingredients
    @ingredients_required.keys
  end

  def total_calories
    ingredients_required.inject(0) do |sum, (ingredient, amount)|
      sum += ingredient.calories * amount
      sum
    end
  end

end
