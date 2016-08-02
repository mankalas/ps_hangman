require "hangman"

TEST_WORD = "HoRSe"

describe Hangman do

  before do
    @hangman = Hangman::Hangman.new(TEST_WORD)
  end

  it "should return only underscores when no guess has been made" do
    @hangman.show_progress.should == "_" * TEST_WORD.length
  end

  it "should show a rightly guessed letter" do
    @hangman.guess("e")
    @hangman.show_progress.should == "____e"
  end

  it "should not show a wrongly guessed letter" do
    @hangman.guess("a")
    @hangman.show_progress.should == "_" * TEST_WORD.length
  end

  it "should not show a badly cased letter if hangman is case sensitive" do
    @hangman.case_sensitive = true
    @hangman.guess("h")
    @hangman.show_progress.should == "_" * TEST_WORD.length
    @hangman.guess("H")
    @hangman.show_progress.should == "H____"
  end

  it "should show a badly cased letter if hangman is case sensitive" do
    @hangman.case_sensitive = false
    @hangman.guess("r")
    @hangman.show_progress.should == "__R__"
    @hangman.guess("S")
    @hangman.show_progress.should == "__RS_"
  end

  it "should end with a win if all letters have been guessed" do
    @hangman.game_over?.should == false
    TEST_WORD.each_char { |c| @hangman.guess(c) }
    @hangman.game_over?.should == true
    @hangman.word_guessed?.should == true
  end

  it "should end with a lose if the word has not been guessed after a
    number of tries" do
    @hangman.game_over?.should == false
    10.times { @hangman.guess('x') }
    @hangman.game_over?.should == true
    @hangman.word_guessed?.should == false
  end

end
