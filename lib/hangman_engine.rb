module Hangman
  MAX_GUESSES = 5
  PLACEHOLDER = "_"

  class Validator
    def initialize(word)
      @word = word
      @guessed_letters = ""
    end
  end

  class CaseSensitiveValidator < Validator
    def initialize(word)
      super(word)
    end

    def validate(letter)
      @guessed_letters << letter
      @word.include? letter
    end

    def letter_guessed?(letter)
      @guessed_letters.include? letter
    end
  end

  class CaseInsensitiveValidator < Validator
    def initialize(word)
      super(word)
    end

    def validate(letter)
      @guessed_letters << letter.downcase
      @word.downcase.include? letter.downcase
    end

    def letter_guessed?(letter)
      @guessed_letters.include? letter.downcase
    end
  end

  class Engine
    attr_reader :number_of_wrong_guesses
    attr_reader :word

    def initialize(word:, case_sensitive: true)
      @word = word
      @number_of_wrong_guesses = 0 # Use ||=?
      @validator = case_sensitive ?
                     CaseSensitiveValidator.new(word) :
                     CaseInsensitiveValidator.new(word)
    end

    def show_progress
      @word.each_char.collect { |c| @validator.letter_guessed?(c) ? c : PLACEHOLDER }.join("")
    end

    def guess(letter)
      @number_of_wrong_guesses += 1 unless @validator.validate(letter)
    end

    def game_over?
      word_guessed? or no_more_guesses?
    end

    def word_guessed?
      @word.each_char.all? { |c| @validator.letter_guessed? c }
    end
    alias_method :win?, :word_guessed?

    def no_more_guesses?
      @number_of_wrong_guesses >= MAX_GUESSES
    end
  end
end
