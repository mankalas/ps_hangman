require 'validators'

module Hangman
  PLACEHOLDER = "_"

  class Engine
    attr_reader :lives
    attr_reader :word

    def initialize(word:, lives:, case_sensitive: true)
      @word = word
      @lives = lives
      @validator = case_sensitive ?
                     CaseSensitiveValidator.new(word) :
                     CaseInsensitiveValidator.new(word)
    end

    def show_progress
      @word.each_char.collect { |c| @validator.letter_guessed?(c) ? c : PLACEHOLDER }.join("")
    end

    def guess(letter)
      @lives -= 1 unless @validator.validate(letter)
    end

    def game_over?
      word_guessed? or no_more_life?
    end

    def word_guessed?
      @word.each_char.all? { |c| @validator.letter_guessed? c }
    end
    alias_method :win?, :word_guessed?

    def no_more_life?
      @lives < 0
    end
  end
end
