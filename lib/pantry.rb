class Pantry
  attr_reader :stock
  def initialize
    @stock = {}
    @stock.default = 0
  end

  def stock_check(ingredient)
    @stock[ingredient]
  end

  def restock(ingredient, amount)
    @stock[ingredient] += amount
  end

  def enough_ingredients_for?(recipe)
    recipe.ingredients_required.all? do |ingredient, amount_required|
      stock[ingredient] >= amount_required
    end
  end

end
