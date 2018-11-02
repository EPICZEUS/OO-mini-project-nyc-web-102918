require_relative '../config/environment.rb'

# onion = Ingredient.new
# beef = Ingredient.new
# carrot = Ingredient.new
# milk = Ingredient.new
# egg = Ingredient.new
# flour = Ingredient.new

# stew = Recipe.new
# stew.add_ingredients([onion, beef, carrot])

# milksteak = Recipe.new
# milksteak.add_ingredients([milk, beef])

# veggies = Recipe.new
# veggies.add_ingredients([onion, carrot])

# bread = Recipe.new
# bread.add_ingredients([egg, milk, flour])

# omelet = Recipe.new
# omelet.add_ingredients([onion, carrot, egg, milk])

# sam = User.new
# matt = User.new
# mike = User.new

# sam.declare_allergen(onion)
# sam.declare_allergen(egg)

# sam.add_recipe_card(bread, Time.now, rand(6))
# sam.add_recipe_card(omelet, Time.now, rand(6))
# sam.add_recipe_card(milksteak, Time.now, rand(6))
# sam.add_recipe_card(veggies, Time.now, rand(6))

# matt.declare_allergen(onion)

# mike.declare_allergen(onion)
# mike.declare_allergen(egg)

def welcome
	puts "Welcome to your recipe manager!"
end

def help
	puts "Enter 'I' to create an ingredient"
	puts "Enter 'U' to create a user"
	puts "Enter 'R' to create a recipe"
	puts "Enter 'A' to enter an allergen"
	puts "Enter 'RC' to create a recipe card"
	puts "Enter 'VIEW' to view information"
end

def run_command(input)
	case input.downcase
	when 'i'
		puts "Enter ingredient name"
		val = gets.strip
		Ingredient.find_or_create_by_name(val)

		puts "Ingredient: '#{val}' created."
	when 'u'
		puts "Enter user name"
		val = gets.strip
		User.find_or_create_by_name(val)

		puts "User: '#{val}' created."
	when 'r'
		puts "Enter recipe name"
		val = gets.strip
		recipe = User.find_or_create_by_name(val)

		puts "Enter ingredient names (space delimited)"
		val = gets.strip

		ingredients = val.split.map{|name| Ingredient.find_by_name(name) }

		if ingredients.any? {|e| e.nil? }
			puts "Invalid ingredient included."
		else
			recipe.add_ingredients(ingredients)
			puts "Recipe: '#{val}' created."
		end
	when 'a'
		puts "Enter user name"
		name = gets.strip
		user = User.find_by_name(name)

		if user.nil?
			puts "User: '#{name}' not found"
			break
		end

		puts "Enter ingredient name"
		name = gets.strip
		ingr = Ingredient.find_by_name(name)

		if ingr.nil?
			puts "Ingredient: '#{name}' not found"
			break
		end

		user.declare_allergen(ingr)
		puts "'#{ingr.name}' has been added to '#{user.name}' allergens."
	when 'rc'
		puts "Enter user name"
		name = gets.strip
		user = User.find_by_name(name)

		if user.nil?
			puts "User: '#{name}' not found"
			break
		end

		puts "Enter recipe name"
		name = gets.strip
		recipe = Recipe.find_by_name(name)

		if recipe.nil?
			puts "Recipe: '#{name}' not found"
			break
		end

		puts "Enter a rating between 1-5"
		rating = 0
		until rating.between?(1..5)
			rating = gets.strip.to_i 
		end

		user.add_recipe_card(recipe, rating)
		puts "Recipe Card for '#{recipe.name}' for '#{user.name}' has been created."
	when "view"
		view
	else
		puts "Please input a valid command."
		help
	end
end

def view
	
end

binding.pry
