require 'sinatra/base'
require './lib/player'
require './lib/game'
require './lib/computer'

class RockPaperScissors < Sinatra::Base

  enable :sessions
  set :views, Proc.new { File.join(root, "views") }
  set :public_folder, Proc.new { File.join(root, "public") }

  GAME = Game.new

  configure :production do
    require 'newrelic_rpm'
  end

  get '/' do
    GAME.one_player
    erb :index
  end

  get '/new-game' do
    if params[:game_type] == "two_players"
      GAME.two_players 
      GAME.players = [] if GAME.players.count >= 2
      erb :new_player
    else
      GAME.players ||= []
      erb :new_player
    end
  end

  post '/register' do 
    session[:player_name] = params[:name]
    player = Player.new(session[:player_name])
    GAME.add(player)
    if GAME.single_player?
      GAME.add(Computer.new)
      erb :play
    else
      ready_to_play?
    end
  end

  post "/play" do
  	GAME.return_player(session[:player_name]).picks = params[:pick]
    if GAME.single_player?
      computer = GAME.return_computer
      computer.picks = computer.random_pick
      erb :outcome
    else
      opponent_picked_option?
    end
  end

  get "/waiting_room" do
    ready_to_play?
  end

  get "/wait_player_pick" do
    opponent_picked_option?
  end

  post "/play_again" do
    GAME.reset_players_picks if GAME.player1.pick != nil and GAME.player2.pick != nil
    erb :play
  end

  def ready_to_play?
    if GAME.ready_to_start?
      erb :play
    else
      erb :waiting_room
    end
  end

  def opponent_picked_option?
    if GAME.return_opponent(session[:player_name]).pick != nil
      erb :outcome
    else
      erb :wait_player_pick
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
