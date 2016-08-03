require 'colorize'

module Hangman
  class ConsoleView

    WELCOME_MESSAGE = "Welcome here!"
    WON_MESSAGE = "Yay! You've won!"
    LOST_MESSAGE = "Too bad, you lose."

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
      puts "#{@engine.show_progress} (#{@engine.lives} wrong guesses left)"
    end

    def game_over
      if @engine.win?
        puts "Yay! You've won!"
      else
        puts LOST_MESSAGE + "The word was '#{@engine.word}'"
      end
    end
  end


  class PsychedelicConsoleView < ConsoleView
    def welcome
      puts WELCOME_MESSAGE.red.on_yellow
    end

    def show_state
      "#{@engine.show_progress} (#{@engine.lives} wrong guesses left)".each_char.map { |c| print c.colorize(String.colors.sample) }
      puts
    end

    def game_over
      if @engine.win?
        puts "Yay! You've won!".yellow.on_green
      else
        puts (LOST_MESSAGE + " The word was '#{@engine.word}'").red.on_black
      end
    end
  end
end
