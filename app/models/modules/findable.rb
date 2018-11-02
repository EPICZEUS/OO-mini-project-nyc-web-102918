module Findable
	def find_by_name(name)
		self.all.find{|i| i.name == name }
	end

	def find_or_create_by_name(name)
		item = self.all.find{|i| i.name == name }

		if item.nil?
			item = self.new(name)
		end

		item
	end
end