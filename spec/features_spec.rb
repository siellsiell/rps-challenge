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

  scenario "User chooses rock, server chooses scissors, user wins" do
    allow(Game).to receive(:random_choice).and_return(:scissors)
    player = "simo"
    visit '/'
    fill_in('name', with: player)
    click_on("Play")
    click_on("rock")
    expect(page).to have_content(
      /#{player} chose rock./
    )
    expect(page).to have_content(
      /Bot chose scissors./
    )
    expect(page).to have_content(/#{player} wins!/)
  end
end
