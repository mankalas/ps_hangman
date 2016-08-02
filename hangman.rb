module Hangman
  MAX_GUESSES = 5
  WORDS = %w(hello world guinness food sea oxymoron)

  class Hangman
    attr_accessor :case_sensitive

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

    def no_more_guesses?
      @number_of_wrong_guesses >= MAX_GUESSES
    end
  end
end
