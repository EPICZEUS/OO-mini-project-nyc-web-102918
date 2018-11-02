class RecipeCard
	@@all = []

	def self.all
		@@all
	end

	attr_accessor :rating
	attr_reader :user, :recipe, :date

	def initialize(rating, user, recipe)
		@rating = rating
		@user = user
		@recipe = recipe
		@date = Time.now

		@@all << self
	end
end