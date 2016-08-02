module Hangman
  MAX_GUESSES = 5
  WORDS = %w(hello world guinness food sea oxymoron)
  UNIX_WORDS_PATH = '/usr/share/dict/words'

  class Engine
    attr_accessor :case_sensitive
    attr_reader :number_of_wrong_guesses
    attr_reader :word

    def initialize(word = nil)
      @word = (word ? word : get_dictionary.sample)
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

    private

    def get_dictionary
      begin
        File.read(UNIX_WORDS_PATH).split
      rescue Errno::ENOENT
        puts "No dictionary found. Falling back to simple word list."
        WORDS
      end
    end
  end
end
