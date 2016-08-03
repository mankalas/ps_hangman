require 'hangman_engine'
require 'hangman_views'

module Hangman
  class Game
    def run(mode)
      engine = Engine.new
      if mode == :normal
        view = ConsoleView.new(engine)
      else
        view = PsychedelicConsoleView.new(engine)
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
end
