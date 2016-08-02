#!/usr/bin/env ruby

require "hangman"
require "hangman_views"

class Game
  def run
    engine = Hangman::Engine.new
    view = Hangman::SoberConsoleView.new(engine)
    view.welcome
    until engine.game_over?
      view.show_state()
      guess = nil
      until view.input_sane? guess
        guess = view.ask_guess
      end
      engine.guess(guess)
    end
    view.game_over
  end
end

game = Game.new
game.run
