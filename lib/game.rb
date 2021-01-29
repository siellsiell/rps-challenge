module Game

GameResult = Struct.new(:bot_choice, :winner)

BOT_NAME = "Bot"
CHOICE_TO_BEATS = {:rock => :scissors, :paper => :rock, :scissors => :paper}

def self.bot_name
  BOT_NAME
end

def self.choices
  CHOICE_TO_BEATS.keys
end

def self.play(username, user_choice)
  bot_choice = self.bot_choice
  if user_choice == bot_choice
    return GameResult.new(bot_choice, nil)
  end
  winner = CHOICE_TO_BEATS[user_choice] == bot_choice ? username : BOT_NAME
  GameResult.new(bot_choice, winner)
end

def self.bot_choice
  self.choices.sample
end

end
