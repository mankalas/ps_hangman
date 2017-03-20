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
      correct_guess = @validator.validate(letter, @word)
      @lives -= 1 unless correct_guess
      correct_guess
    end

    def guess_word(word)
      correct_guess = @word == word
      @lives -= 1 unless correct_guess
      correct_guess
    end

    def game_over?
      win? || no_more_life?
    end

    def win?
      @validator.word_guessed?(@word)
    end

    def no_more_life?
      @lives <= 0
    end
    alias_method :lost?, :no_more_life?
  end
end
