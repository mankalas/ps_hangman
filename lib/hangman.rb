require 'engine'
require 'views'

module Hangman
  WORDS = %w(hello world guinness food sea oxymoron)
  UNIX_WORDS_PATH = '/usr/share/dict/words'
  DEFAULT_MAX_LIVES = 5

  class Game
    attr_reader :engine

    def initialize(word: pick_word,
                   lives:  DEFAULT_MAX_LIVES,
                   view_class: ConsoleView)
      @engine = Engine.new(word: word,
                           lives: lives)
      @view = view_class.new(@engine)
    end

    def run()
      @view.welcome
      until @engine.game_over?
        @view.show_state()
        guess = nil
        until @view.input_sane? guess
          guess = @view.ask_guess
        end
        @engine.guess(guess)
      end
      @view.game_over
    end

    def pick_word
      begin
        File.read(UNIX_WORDS_PATH).split.sample
      rescue Errno::ENOENT
        WORDS.sample
      end
    end
  end
end
