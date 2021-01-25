require 'sinatra/base'

class RockPaperScissors < Sinatra::Base
  get '/' do
   erb :index
  end

  get '/play' do
    erb :play, :locals => { :name => params[:name] }
  end

  post '/choose' do
    erb :end, :locals => { 
      :user_choice => params[:choice],
      :server_choice => :rock,
      :winner_message => "You lose!"
    }
  end
end



