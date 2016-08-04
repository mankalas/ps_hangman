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

  it "instanciate a Game with no argument" do
    Hangman::Game.new
  end

  it "runs a normal game without crashing" do
    Hangman::Game.new(view_class: TestView).run
  end

  it "takes into account the given word" do
    game = Hangman::Game.new(TEST_WORD)
    expect(game.engine.word).to eq TEST_WORD
  end

  it "takes into account the given number of lives" do
    NB_LIVES = 42
    game = Hangman::Game.new(TEST_WORD, NB_LIVES)
    expect(game.engine.lives).to eq NB_LIVES
  end

end
