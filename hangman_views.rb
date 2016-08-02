#require 'colorize'

module Hangman
  class ConsoleView

    WELCOME_MESSAGE = "Welcome here!"

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
      puts "#{@engine.show_progress} (#{MAX_GUESSES - @engine.number_of_wrong_guesses} wrong guesses left)"
    end

    def game_over
      if @engine.win?
        puts "Yay! You've won!"
      else
        puts "Too bad, you lose. The word was '#{@engine.word}'"
      end
    end
  end

  class PsychedelicConsoleView < ConsoleView
    def welcome
      puts WELCOME_MESSAGE.red
    end
  end
end
