#!/usr/bin/env ruby

require "hangman"
# Should be in 'hangman_views', but messes with rspec.
require 'colorize'
require "hangman_views"

class Game
  def run(mode)
    engine = Hangman::Engine.new
    if mode == :normal
      view = Hangman::ConsoleView.new(engine)
    else
      view = Hangman::PsychedelicConsoleView.new(engine)
    end
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
puts "1- Normal mode; 2- LSD mode"
mode = 0
until mode == 1 or mode == 2
  mode = gets.chomp.to_i
end
game.run({1=> :normal, 2=> :lsd}[mode])
