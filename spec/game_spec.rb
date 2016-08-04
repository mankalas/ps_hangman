require 'hangman'
require 'views'

class TestView < Hangman::ConsoleView
  def welcome
  end

  def ask_guess
    ('a'..'z').to_a.sample
  end

  def show_state
  end

  def game_over
    @engine.game_over?
  end
end

describe Hangman::Game do

  describe "#instanciate" do
    it "accepts no parameter" do
      Hangman::Game.new
    end

    it "accepts a word as parameter" do
      game = Hangman::Game.new(word: TEST_WORD)
      expect(game.engine.word).to eq TEST_WORD
    end

    it "accepts a number of lives as parameter" do
      NB_LIVES = 42
      game = Hangman::Game.new(lives: NB_LIVES)
      expect(game.engine.lives).to eq NB_LIVES
    end
  end

  describe "#run" do
    it "runs a normal game" do
      Hangman::Game.new(view_class: TestView).run
    end
  end
end
