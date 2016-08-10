require 'engine'
require 'views'

module Hangman
  class Game
    def run(engine:, view:)
      view.welcome

      until engine.game_over?
        view.show_state

        guess = view.ask_guess
        until view.input_sane?(guess)
          guess = view.ask_guess
        end

        engine.guess(guess)
      end

      view.game_over
    end
  end

  class WordPicker
    UNIX_WORDS_PATH = '/usr/share/dict/words'
    def pick
      File.read(UNIX_WORDS_PATH).split.sample
    end
  end
end
