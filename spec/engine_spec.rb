require 'engine'

TEST_WORD = "HoRSe"
TEST_NB_LIVES = 5
DUMMY_CHAR = '@'

describe Hangman::Engine do
  let(:engine) { Hangman::Engine.new(word: TEST_WORD,
                                     lives: TEST_NB_LIVES) }

  context "when no guess has been made yet" do
    it "no letter should be revealed" do
      expect(engine.progress.values.any?).to be_falsey
    end

    it "should have full lives" do
      expect(engine.lives).to eq TEST_NB_LIVES
    end
  end

  context "when one letter has been rightly guessed" do
    let(:random_letter) { TEST_WORD.chars.to_a.sample }

    before do
      engine.guess(random_letter)
    end

    it "the letter should be marked as revealed" do
      expect(engine.progress[random_letter]).to be_truthy
    end

    it "still should have full lives" do
      expect(engine.lives).to eq TEST_NB_LIVES
    end
  end

  context "when one letter has been wrongly guessed" do
    before do
      engine.guess(DUMMY_CHAR)
    end

    it "no letter should not be marked as revealed" do
      expect(engine.progress.values.any?).to be_falsey
    end

    it "should have lost one life" do
      expect(engine.lives).to eq (TEST_NB_LIVES - 1)
    end
  end

  context "when winning a game" do
    before do
      TEST_WORD.each_char { |char| engine.guess(char) }
    end

    it "all letters should have been marked as revealed" do
      expect(engine.progress.values.all?).to be_truthy
    end

    it "the game should be over" do
      expect(engine.game_over?).to be true
      expect(engine.word_guessed?).to be true
      expect(engine.no_more_life?).to be false
    end

    it "the game should be won" do
      expect(engine.win?).to be true
    end
  end

  context "when losing a game" do
    before do
      (TEST_NB_LIVES + 1).times { engine.guess(DUMMY_CHAR) }
    end

    it "not all letters should have been marked as revealed" do
      expect(engine.progress.values.all?).to be_falsey
    end

    it "the game should be over" do
      expect(engine.game_over?).to be true
      expect(engine.word_guessed?).to be false
      expect(engine.no_more_life?).to be true
    end

    it "the game should be lose" do
      expect(engine.win?).to be false
    end
  end
end
