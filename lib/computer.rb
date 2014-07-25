require_relative 'player'

class Computer < Player

	def initialize
		super("Computer")
	end

	def random_pick
		["Rock","Paper","Scissors"].sample
	end

end