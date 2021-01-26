require 'capybara'
require 'capybara/rspec'
require 'rspec'
require "game"


feature 'Testing setup' do
  scenario "Can run app and check page content" do
    visit '/'
    expect(page).to have_content("What's your name?")
  end
end

feature 'Can submit player name and see name on screen' do
  ["Simo", "Tatsiana"].each do |name|
    scenario "Enter name #{name}, submit and go to /play" do
      visit '/'
      fill_in('name', with: name)
      click_on('Play')
      #expect(page).to have_current_path("/play?name=")
      expect(page).to have_content("Hi #{name}, let's play!")
    end
  end
end


# feature 'Can choose rock, paper or scissors' do
#   ["rock", "paper", "scissors"].each do |option|
#     scenario "Click on #{option}, opponent choice and winner is announced" do
#       player = "simo"
#       visit '/'
#       fill_in('name', with: player)
#       click_on('Play')
#       click_on(option)
#       expect(page).to have_content(/#{player} chose #{option}. Bot chose (rock|paper|scissors)./)
#       expect(page).to have_content(/(It's a draw|(#{option}|Bot) wins)!/)
#     end
#   end
# end

feature 'Can choose rock, paper or scissors and find out game outcome' do

    #:username: :user3, :user => :paper, :bot => :rock, :winnner => :user3,
  ([ :username => :user1, :user => :rock, :bot => :scissors, :winner => :user1 ] +
  [:username => :user2, :user => :scissors, :bot => :paper, :winner => :user2 ])
    .each do |params|
    scenario "#{params[:username]} chooses #{params[:user]}, server chooses #{params[:bot]}, winner is #{params[:winner]}" do
      allow(Game).to receive(:random_choice).and_return(params[:bot])
      player = params[:username]
      visit '/'
      fill_in('name', with: player)
      click_on("Play")
      click_on(params[:user])
      expect(page).to have_content(
        /#{player} chose #{params[:user]}./
      )
      expect(page).to have_content(
        /Bot chose #{params[:bot]}./
      )
      expect(page).to have_content(/#{player} wins!/)
    end
  end
end
