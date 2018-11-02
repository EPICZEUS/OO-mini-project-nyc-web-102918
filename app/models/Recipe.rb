class Recipe
	@@all = []

	def self.all
		@@all		
	end

	def self.most_popular
		@@all.sort{|a, b| b.users.length <=> a.users.length }.first		
	end

	def self.allergen_free
		@@all.select{|recipe| recipe.allergens.empty? }
	end

	attr_reader :name

	def initialize(name)
		@name = name

		@@all << self
	end

	def add_ingredients(ingredients)
		ingredients.each{|ingredient| RecipeIngredient.new(ingredient, self) }
	end

	def users
		RecipeCard.all.select{|card| card.recipe == self }
	end

	def ingredients
		ingrs = RecipeIngredient.all.select{|ingr| ingr.recipe == self }

		ingrs.map{|ingr| ingr.ingredient }
	end

	def allergens
		gens = Allergen.all.select{|gen| ingredients.include?(gen.ingredient) }

		gens.map{|gen| gen.ingredient }
	end
end