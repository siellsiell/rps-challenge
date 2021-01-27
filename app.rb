require 'sinatra/base'
require 'game'

class RockPaperScissors < Sinatra::Base
  enable :sessions

  get '/' do
   erb :index
  end

  post '/play' do
    session[:username] = params[:name]
    redirect "/play"
  end

  get '/play' do
    erb :play, :locals => {
      :name => session[:username],
      :choices => Game.choices
    }
  end

  post '/choose' do
    session[:user_choice] = params[:choice]
    redirect '/end'
  end

  get '/end' do
    username = session.delete(:username)
    user_choice = session.delete(:user_choice).to_sym
    result = Game.play(user_choice)
    winner = result.user_wins? ? username : Game.bot_name
    erb :end, :locals => {
      :username => username,
      :user_choice => user_choice,
      :server_choice => result.bot_choice,
      :winner => winner
    }
  end
end

