require 'engine'
require 'views'

module Hangman
  WORDS = %w(hello world guinness food sea oxymoron)
  UNIX_WORDS_PATH = '/usr/share/dict/words'
  DEFAULT_MAX_LIVES = 5

  class Game
    def initialize(mode: :normal,
                   lives: DEFAULT_MAX_LIVES)
      @mode = mode
      @lives = lives
    end

    def run()
      engine = Engine.new(word: pick_word,
                          lives: @lives)
      if @mode == :normal
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

    def pick_word
      begin
        File.read(UNIX_WORDS_PATH).split.sample
      rescue Errno::ENOENT
        WORDS.sample
      end
    end
  end
end
