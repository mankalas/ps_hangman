#require 'colorize'

module Hangman

  class View
    def initialize(engine:)
      @engine = engine
    end

    def input_sane?(input)
      !!(input =~ /^[[:alpha:]]$/)
    end
  end

  class ConsoleView < View
    WELCOME_MESSAGE = "Welcome here!"
    WON_MESSAGE = "Yay! You've won!"
    LOST_MESSAGE = "Too bad, you lose. The word was '%s'"
    GAME_STATE = "%s (%s lives remaining)"
    PLACEHOLDER = "_"

    def build_welcome_message
      WELCOME_MESSAGE
    end

    def build_state_message
      progress_string = @engine.progress.each.map { |k, v| v ? k : PLACEHOLDER }.join
      GAME_STATE % [progress_string, @engine.lives]
    end

    def build_game_over_message
      @engine.win? ? WON_MESSAGE : build_lost_message
    end

    def build_lost_message
      LOST_MESSAGE % [@engine.word]
    end

    def welcome
      puts build_welcome_message
    end

    def show_state
      puts build_state_message
    end

    def game_over
      puts build_game_over_message
    end

    def ask_guess
      gets.chomp
    end
  end

  class LSDConsoleView < ConsoleView
    def welcome
      puts build_welcome_message.red.on_yellow
    end

    def show_state
      build_state_message.each_char.map { |c| print c.colorize(String.colors.sample) }
      puts
    end

    def game_over
      message = build_game_over_message
      if @engine.win?
        puts message.yellow.on_green
      else
        puts message.red.on_black
      end
    end
  end
end
