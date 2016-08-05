module Hangman
  class Validator
    def initialize(word)
      @word = word
      @guessed_letters = ""
    end
  end

  class CaseSensitiveValidator < Validator
    def validate(letter)
      @guessed_letters << letter
      @word.include?(letter)
    end

    def letter_guessed?(letter)
      @guessed_letters.include?(letter)
    end
  end

  class CaseInsensitiveValidator < Validator
    def validate(letter)
      @guessed_letters << letter.downcase
      @word.downcase.include?(letter.downcase)
    end

    def letter_guessed?(letter)
      @guessed_letters.include?(letter.downcase)
    end
  end
end
