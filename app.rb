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
    erb :end, :locals => {
      :username => username,
      :user_choice => session.delete(:choice),
      :server_choice => Game.random_choice,
      :winner => "#{username}"
    }
  end
end
