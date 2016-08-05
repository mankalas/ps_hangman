require 'validators'

module Hangman
  PLACEHOLDER = "_"

  class Engine
    attr_reader :lives, :word

    def initialize(word:, lives:, case_sensitive: true)
      @word = word
      @lives = lives
      @validator = case_sensitive ?
                     CaseSensitiveValidator.new(word) :
                     CaseInsensitiveValidator.new(word)
    end

    def show_progress
      @word.each_char.collect do |char|
        @validator.letter_guessed?(char) ? char : PLACEHOLDER
      end.join
    end

    def guess(letter)
      @lives -= 1 unless @validator.validate(letter)
    end

    def game_over?
      word_guessed? || no_more_life?
    end

    def word_guessed?
      @word.each_char.all? { |char| @validator.letter_guessed?(char) }
    end
    alias_method :win?, :word_guessed?

    def no_more_life?
      @lives < 0
    end
  end
end
