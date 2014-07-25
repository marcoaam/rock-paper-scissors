require 'sinatra/base'
require './lib/player'
require './lib/game'
require './lib/computer'

class RockPaperScissors < Sinatra::Base

  set :views, Proc.new { File.join(root, "views") }
  set :public_folder, Proc.new { File.join(root, "public") }

  configure :production do
    require 'newrelic_rpm'
  end

  get '/' do
    erb :index
  end

  get '/new-game' do
  	erb :new_player
  end

  post '/register' do 
  	@player = params[:name]
  	erb :play	
  end

  post "/play" do
  	player = Player.new(params[:name])
    @player = params[:name]
  	player.picks = params[:pick]
  	computer = Computer.new
    computer.picks = computer.random_pick
  	@game = Game.new(player, computer)
  	erb :outcome
  end

  post "/play_again" do
    @player = params[:name]
    erb :play
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
