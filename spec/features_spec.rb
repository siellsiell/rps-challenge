require 'capybara'
require 'capybara/rspec'
require 'rspec'
require "game"


feature 'Testing setup' do
  scenario "Can run app and check page content" do
    visit '/'
    expect(page).to have_content(/Play RPS?/)
  end
end

feature 'Can submit player name and see name on screen' do
  ["Simo", "Tatsiana"].each do |name|
    scenario "Enter name #{name}, submit and go to /play" do
      visit '/'
      fill_in('name', with: name)
      click_on('Play')
      expect(page).to have_content("Hi #{name}, let's play!")
    end
  end
end



feature 'Can choose rock, paper or scissors and find out game outcome' do

  (
    [ :username => :user1, :user => :rock, :bot => :scissors, :winner => :user1 ] +
    [ :username => :user2, :user => :scissors, :bot => :paper, :winner => :user2 ] +
    [ :username => :user3, :user => :paper, :bot => :rock, :winner => :user3 ] +

    [ :username => :user1, :user => :scissors, :bot => :rock, :winner => :Bot ] +
    [ :username => :user2, :user => :paper, :bot => :scissors, :winner => :Bot ] +
    [ :username => :user3, :user => :rock, :bot => :paper, :winner => :Bot ]
  ).each do |params|
    scenario %{
        #{params[:username]} chooses #{params[:user]}, server chooses #{params[:bot]}, winner is #{params[:winner]}
      } do
      allow(Game).to receive(:bot_choice).and_return(params[:bot])
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
      expect(page).to have_content(/#{params[:winner]} wins!/)
    end
  end


  (
    [ :rock, :paper, :scissors] 
  ).each do |choice|
    scenario "both choose #{choice}, game ends in draw" do
      allow(Game).to receive(:bot_choice).and_return(choice)
      player = "intrepid koala"
      visit '/'
      fill_in('name', with: player)
      click_on("Play")
      click_on(choice)
      expect(page).to have_content(
        /#{player} chose #{choice}./
      )
      expect(page).to have_content(
        /Bot chose #{choice}./
      )
      expect(page).to have_content(/It's a draw./)
    end
  end
end
