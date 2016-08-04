require 'engine'

describe Hangman::Engine do

  let(:engine) { Hangman::Engine.new(TEST_WORD, 5) }

  it "should return only underscores when no guess has been made" do
    expect(engine.show_progress).to eq "_" * TEST_WORD.length
  end

  it "should show a rightly guessed letter" do
    engine.guess("e")
    expect(engine.show_progress).to eq "____e"
  end

  it "should not show a wrongly guessed letter" do
    engine.guess("a")
    expect(engine.show_progress).to eq "_" * TEST_WORD.length
  end

  it "should end with a win if all letters have been guessed" do
    expect(engine.game_over?).to be false
    TEST_WORD.each_char { |c| engine.guess(c) }
    expect(engine.game_over?).to be true
    expect(engine.win?).to be true
  end

  it "should end with a lose if the word has not been guessed after a
    number of tries" do
    expect(engine.game_over?).to be false
    10.times { engine.guess('x') }
    expect(engine.game_over?).to be true
    expect(engine.win?).to be false
  end
end
