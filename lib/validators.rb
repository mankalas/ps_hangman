require 'set'

module Hangman
  class Validator
    attr_reader :guessed_letters

    def initialize
      @guessed_letters = Set.new
    end

    def register_letter(letter)
      @guessed_letters << letter
    end

    def letter_guessed?(letter)
      @guessed_letters.include?(letter)
    end

    def progress(word)
      word.each_char.collect do |char|
        [char, letter_guessed?(char)]
      end.to_h
    end

    def word_guessed?(word)
      word.each_char.all?(&method(:letter_guessed?))
    end

    def valid_input?(letter)
      letter and letter != ''
    end
  end

  class CaseSensitiveValidator < Validator
    def validate(letter, word)
      if valid_input?(letter)
        register_letter(letter)
        word.include?(letter)
      end
    end
  end

  class CaseInsensitiveValidator < Validator
    def validate(letter, word)
      if valid_input?(letter)
        register_letter(letter)
        word.downcase.include?(letter.downcase)
      end
    end

    def letter_guessed?(letter)
      super(letter.downcase)
    end

    def register_letter(letter)
      super(letter.downcase)
    end
  end

  # class FuzzyValidator < Validator
  #   def initialize(word)
  #     super(word)
  #     @next = CaseSensitiveValidator.new(word)
  #   end

  #   def validate(letter)
  #     if valid_input?(letter)
  #       (-1..1).each do |index|
  #         current_letter = (letter.ord + index).chr
  #         @next.validate(current_letter)
  #       end.any?
  #     end
  #   end
  # end

  # class OrderedValidator < Validator
  #   def initialize(word)
  #     super(word)
  #     @rank = 0
  #   end

  #   def validate(letter)
  #     full_word = @word
  #     @word = full_word[@rank]
  #     if @next.validate(letter)
  #       @rank += 1
  #       @guessed_letters = ""
  #     end
  #     @word = full_word
  #   end
  # end
end
