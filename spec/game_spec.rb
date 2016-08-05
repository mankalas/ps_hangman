require 'hangman'
require 'views'

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
      view_instance = double("view_instance")
      allow(view_instance).to receive(:welcome).and_return("Hi!")
      allow(view_instance).to receive(:show_state).and_return("Chiche")
      allow(view_instance).to receive(:ask_guess).and_return(('a'..'z').to_a.sample)
      allow(view_instance).to receive(:input_sane?).and_return(true)
      allow(view_instance).to receive(:game_over).and_return("GO")
      view_class = double("view_class")
      allow(view_class).to receive(:new).and_return (view_instance)
      #allow(view).to receive(:ask_guess).and_return(('a'..'z').to_a.sample)
      Hangman::Game.new(view_class: view_class).run
    end
  end
end
