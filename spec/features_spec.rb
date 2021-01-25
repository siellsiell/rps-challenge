require 'capybara'
require 'capybara/rspec'
require 'rspec'


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


feature 'Can choose rock, paper or scissors' do
  ["rock", "paper", "scissors"].each do |option|
    scenario "Click on #{option}, opponent choice and winner is announced" do
      visit '/play?name=Simo'
      click_on(option)
      expect(page).to have_content(/You chose #{option}. I chose (rock|paper|scissors)./)
      expect(page).to have_content(/(It's a draw|(You (win|lose)))!/)
    end
  end
end
