require 'sinatra/base'
require_relative './lib/player'
require_relative './lib/game'
require_relative './lib/computer'

class RockPaperScissors < Sinatra::Base

  enable :sessions
  set :views, Proc.new { File.join(root, "views") }
  set :public_folder, Proc.new { File.join(root, "public") }

  GAME = Game.new

  configure :production do
    require 'newrelic_rpm'
  end

  get '/' do
    erb :index
  end

  get '/new-game' do
    session[:game_type] = params[:game_type]
    if session[:game_type] == "two_players"
      GAME.players = [] if GAME.players.count >= 2
      erb :new_player
    else
      erb :new_player
    end
  end

  post '/register' do 
    session[:player_name] = params[:name]
    if session[:game_type] == "single_player"
      erb :play
    else
      player = Player.new(session[:player_name])
      GAME.add(player)
      ready_to_play?
    end
  end

  post "/play" do
    if session[:game_type] == "single_player"
      @game = Game.new
      player = Player.new(session[:player_name])
      player.picks = params[:pick]
      computer = Computer.new
      computer.picks = computer.random_pick
      @game.add(player)
      @game.add(computer)
      erb :outcome
    else
      GAME.return_player(session[:player_name]).picks = params[:pick]
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
    @game = GAME
    if session[:game_type] == "two_players"
      GAME.reset_players_picks if GAME.player1.pick != nil and GAME.player2.pick != nil
      erb :play
    else
      erb :play
    end
  end

  def ready_to_play?
    @game = GAME
    if GAME.ready_to_start?
      erb :play
    else
      erb :waiting_room
    end
  end

  def opponent_picked_option?
    @game = GAME
    if GAME.return_opponent(session[:player_name]).pick != nil
      erb :outcome
    else
      erb :wait_player_pick
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
