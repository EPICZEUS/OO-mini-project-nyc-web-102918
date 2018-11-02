class Ingredient
	extend Findable
	
	@@all = []

	def self.all
		@@all
	end

	def self.most_common_allergen
		@@all.sort do |a, b|
			a_count = User.all.select{|user| user.allergens.include?(a) }.length
			b_count = User.all.select{|user| user.allergens.include?(b) }.length

			b_count <=> a_count
		end.first
	end

	attr_reader :name

	def initialize(name)
		@name = name

		@@all << self
	end
end