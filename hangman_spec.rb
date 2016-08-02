require "hangman"

TEST_WORD = "HoRSe"

describe Hangman::Engine do

  before do
    @hangman = Hangman::Engine.new(TEST_WORD)
  end

  it "should return only underscores when no guess has been made" do
    expect(@hangman.show_progress).to eq "_" * TEST_WORD.length
  end

  it "should show a rightly guessed letter" do
    @hangman.guess("e")
    expect(@hangman.show_progress).to eq "____e"
  end

  it "should not show a wrongly guessed letter" do
    @hangman.guess("a")
    expect(@hangman.show_progress).to eq "_" * TEST_WORD.length
  end

  it "should not show a badly cased letter if hangman is case sensitive" do
    @hangman.case_sensitive = true
    @hangman.guess("h")
    expect(@hangman.show_progress).to eq "_" * TEST_WORD.length
    @hangman.guess("H")
    expect(@hangman.show_progress).to eq "H____"
  end

  it "should show a badly cased letter if hangman is case sensitive" do
    @hangman.case_sensitive = false
    @hangman.guess("r")
    expect(@hangman.show_progress).to eq "__R__"
    @hangman.guess("S")
    expect(@hangman.show_progress).to eq "__RS_"
  end

  it "should end with a win if all letters have been guessed" do
    expect(@hangman.game_over?).to eq false
    TEST_WORD.each_char { |c| @hangman.guess(c) }
    expect(@hangman.game_over?).to eq true
    expect(@hangman.win?).to eq true
  end

  it "should end with a lose if the word has not been guessed after a
    number of tries" do
    expect(@hangman.game_over?).to eq false
    10.times { @hangman.guess('x') }
    expect(@hangman.game_over?).to eq true
    expect(@hangman.win?).to eq false
  end

end

describe Hangman::ConsoleView do
  it "should sanitize user's input" do
    view = Hangman::ConsoleView.new(nil)
    expect(view.input_sane? "a").to be true
    expect(view.input_sane? "A").to be true
    expect(view.input_sane? "1").to be false
    expect(view.input_sane? "aa").to be false
    expect(view.input_sane? "#").to be false
  end
end
