#require 'colorize'

module Hangman

  class ConsoleView

    WELCOME_MESSAGE = "Welcome here!"
    WON_MESSAGE = "Yay! You've won!"
    LOST_MESSAGE = "Too bad, you lose. The word was '%s'"
    GAME_STATE = "%s (%s wrong guesses left)"

    def initialize(engine)
      @engine = engine
    end

    def welcome
      puts WELCOME_MESSAGE
    end

    def ask_guess
      gets.chomp
    end

    def input_sane?(input = nil)
      !!(input =~ /^[[:alpha:]]$/)
    end

    def show_state
      puts GAME_STATE % [@engine.show_progress, @engine.lives]
    end

    def game_over
      if @engine.win?
        puts WON_MESSAGE
      else
        puts LOST_MESSAGE % [@engine.validator.word]
      end
    end
  end

  class LSDConsoleView < ConsoleView
    def welcome
      puts WELCOME_MESSAGE.red.on_yellow
    end

    def show_state
      final_string = GAME_STATE % [@engine.show_progress, @engine.lives]
      final_string.each_char.map { |c| print c.colorize(String.colors.sample) }
      puts
    end

    def game_over
      if @engine.win?
        puts WON_MESSAGE.yellow.on_green
      else
        puts (LOST_MESSAGE % [@engine.word]).red.on_black
      end
    end
  end
end
