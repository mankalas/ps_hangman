require 'engine'
require 'views'

module Hangman
  class Runner
    def initialize
      @game = Hangman::Game.new
      validator = Hangman::CaseInsensitiveValidator.new
      word_picker = Hangman::WordPicker.new
      @engine = Hangman::Engine.new(word: word_picker.pick, lives: 5, validator: validator)
      @view = Hangman::ConsoleView.new(engine: @engine)
    end

    def run
      @game.run(engine: @engine, view: @view)
    end
  end

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
