module Hangman
  MAX_GUESSES = 5
  WORDS = %w(hello world guinness food sea oxymoron)

  class Engine
    attr_accessor :case_sensitive
    attr_reader :number_of_wrong_guesses
    attr_reader :word

    def initialize(word = WORDS.sample)
      @word = word
      @number_of_wrong_guesses ||= 0
      @guessed_letters = ""
      @case_sensitive = true
    end

    def show_progress
      @word.each_char.collect { |c| (letter_guessed?(c) ? c : "_") }.join("")
    end

    def guess(letter)
      if @case_sensitive
        @guessed_letters << letter
        @number_of_wrong_guesses += 1 unless @word.include? letter
      else
        @guessed_letters << letter.downcase
        @number_of_wrong_guesses += 1 unless @word.downcase.include? letter.downcase
      end
    end

    def letter_guessed?(letter)
      @guessed_letters.include? (@case_sensitive ? letter : letter.downcase)
    end

    def game_over?
      word_guessed? or no_more_guesses?
    end

    def word_guessed?
      @word.each_char.all? { |c| letter_guessed? c }
    end
    alias_method :win?, :word_guessed?

    def no_more_guesses?
      @number_of_wrong_guesses >= MAX_GUESSES
    end
  end

  class ConsoleView
    def initialize(engine)
      @engine = engine
    end

    def welcome
      puts "Welcome here!"
    end

    def show_state
      puts "#{@engine.show_progress} (#{MAX_GUESSES - @engine.number_of_wrong_guesses} wrong guesses left)"
    end

    def ask_guess
      gets.chomp
    end

    def input_sane?(input = nil)
      !!(input =~ /^[[:alpha:]]$/)
    end

    def game_over
      if @engine.win?
        puts "Yay! You've won!"
      else
        puts "Too bad, you lose. The word was '#{@engine.word}'"
      end
    end
  end

  class Game
    def run
      engine = Engine.new
      view = ConsoleView.new(engine)
      view.welcome
      until engine.game_over?
        view.show_state()
        until view.input_sane?
          guess = view.ask_guess
          view.input_sane? guess
        end
        engine.guess(guess)
      end
      view.game_over
    end
  end
end
