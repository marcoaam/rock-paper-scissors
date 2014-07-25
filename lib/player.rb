class Player

	attr_reader :name
	attr_writer :picks

	def initialize(name)
		@name = name
	end

	def pick
		@picks
	end

end