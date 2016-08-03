require 'hangman_engine'
require 'hangman_views'

module Hangman
  WORDS = %w(hello world guinness food sea oxymoron)
  UNIX_WORDS_PATH = '/usr/share/dict/words'

  class Game
    def run(mode)
      engine = Engine.new(pick_word)
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

    def pick_word
      begin
        File.read(UNIX_WORDS_PATH).split.sample
      rescue Errno::ENOENT
        WORDS.sample
      end
    end
  end
end
