require 'validators'

module Hangman
  class Engine
    attr_reader :word, :lives

    def initialize(word:, lives:, validator:)
      @word = word
      @lives = lives
      @validator = validator
    end

    def progress
      @validator.progress(@word)
    end

    def guess(letter)
      @lives -= 1 unless @validator.validate(letter, @word)
    end

    def game_over?
      win? || no_more_life?
    end

    def win?
      @validator.word_guessed?(@word)
    end

    def no_more_life?
      @lives < 0
    end
  end
end
