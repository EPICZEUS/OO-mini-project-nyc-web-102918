class User
	extend Findable

	@@all = []

	def self.all
		@@all
	end

	attr_reader :name

	def initialize(name)
		@name = name

		@@all << self
	end

	def add_recipe_card(recipe, rating)
		RecipeCard.new(rating, self, recipe)
	end

	def declare_allergen(ingredient)
		Allergen.new(ingredient, self)
	end

	def top_three_recipes
		sorted = recipe_cards.sort{|a, b| b.rating <=> a.rating}
		sorted[0..2]
	end

	def safe_recipes
		recipes.select do |recipe|
			!recipe.ingredients.any? do |ingredient|
				allergens.include?(ingredient)				
			end
		end
	end

	def most_recent_recipe
		recipes.last
	end

	def recipe_cards
		RecipeCard.all.select{|card| card.user == self }
	end

	def recipes
		recipe_cards.map{|card| card.recipe }
	end

	def allergens
		gens = Allergen.all.select{|gen| gen.user == self }

		gens.map{|gen| gen.ingredient }
	end
end