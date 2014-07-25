class Game 

	attr_reader :players, :player1, :player2

	BEATS = {rock: :scissors, scissors: :paper, paper: :rock}

	def initialize(player1, player2)
		@player1 = player1
		@player2 = player2
		@players = [@player1, @player2]
	end

	def winner
		return "Draw" if player1.pick == player2.pick
		return player1  if BEATS[normalize(player1.pick)] == normalize(player2.pick)
		player2
	end

	def normalize(pick)
		pick.downcase.to_sym
	end
end