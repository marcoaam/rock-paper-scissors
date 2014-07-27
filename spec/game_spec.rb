require 'game' 

describe Game do 
	let(:player1) { double :player1, name: "Stephen" }
	let(:player2) { double :player1, name: "Enrique" }
	let(:game)    { Game.new                         }

	it "Doesn't have players at the beginning" do
		expect(game.players).to eq []
	end

	it 'players can be added' do
		game.add(player1)
		expect(game.players).to eq [player1]
	end

	it 'is ready to play when 2 players have been added' do
		game.add(player1)
		game.add(player2)
		expect(game).to be_ready_to_start
	end

	it 'returns the player using the name as argument' do
		game.add(player1)
		game.add(player2)
		expect(game.return_player("Stephen")).to eq player1
	end

	it 'returns the opponent using the name as argument' do
		game.add(player1)
		game.add(player2)
		expect(game.return_opponent("Stephen")).to eq player2
	end

	it 'can reset the player picks' do
		game.add(player1)
		game.add(player2)

		expect(game.player1).to receive(:picks=).with(nil)
		expect(game.player2).to receive(:picks=).with(nil)
		game.reset_players_picks
	end

	context 'when playing' do

		it 'player one picks rock, player two picks scissors' do
			game.players = [player1, player2]
			allow(player1).to receive(:pick).and_return("Rock")
			allow(player2).to receive(:pick).and_return("Scissors")
			expect(game.winner).to eq player1
		end

		it 'player one picks paper, player two picks scissors' do
			game.players = [player1, player2]
			allow(player1).to receive(:pick).and_return("Paper")
			allow(player2).to receive(:pick).and_return("Scissors")
			expect(game.winner).to eq player2
		end

		it "player one picks paper, player two picks rock" do
			game.players = [player1, player2]
			allow(player1).to receive(:pick).and_return("Paper")
			allow(player2).to receive(:pick).and_return("Rock")
			expect(game.winner).to eq player1
		end

		it "can be a draw" do
			game.players = [player1, player2]
			allow(player1).to receive(:pick).and_return("Paper")
			allow(player2).to receive(:pick).and_return("Paper")
			expect(game.winner).to eq "Draw"
		end

	end

end