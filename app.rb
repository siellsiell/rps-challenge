require 'sinatra/base'
require 'game'

class RockPaperScissors < Sinatra::Base
  enable :sessions

  get '/' do
   erb :index
  end

  post '/play' do
    session[:name] = params[:name]
    redirect "/play"
  end

  get '/play' do
    erb :play, :locals => { :name => session[:name] }
  end

  post '/choose' do
    session[:choice] = params[:choice]
    redirect '/end'
  end

  get '/end' do
    username = session.delete(:name)
    user_choice = session.delete(:choice).to_sym
    server_choice = Game.random_choice
    puts "Server choice: #{server_choice} User choice #{user_choice}"
    winner = Game.wins_against?(user_choice, server_choice) ? username : :Bot
    erb :end, :locals => {
      :username => username,
      :user_choice => user_choice,
      :server_choice => server_choice,
      :winner => winner
    }
  end
end

