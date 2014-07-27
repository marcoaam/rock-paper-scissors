class Game 

	attr_accessor :players

	BEATS = {rock: :scissors, scissors: :paper, paper: :rock}

	def initialize
		@single_player = true
		@players = []
	end

	def player1
		@players.first
	end

	def player2
		@players.last
	end

	def add(player)
		@players << player
	end

	def reset_players_picks
		@players.each { |player| player.picks = nil }
	end

	def winner
		return "Draw" if player1.pick == player2.pick
		return player1  if BEATS[normalize(player1.pick)] == normalize(player2.pick)
		player2
	end

	def normalize(pick)
		pick.downcase.to_sym
	end

	def ready_to_start?
		players.count == 2
	end

	def return_player(player_name)
		@players.select { |player| player_name == player.name }.first
	end

	def return_opponent(player_name)
		@players.reject { |player| player_name == player.name }.first
	end
	
end