require 'engine'

TEST_WORD = "HoRSe"
TEST_NB_LIVES = 5
DUMMY_CHAR = '@'

describe Hangman::Engine do
  let(:engine) { Hangman::Engine.new(word: TEST_WORD,
                                     lives: TEST_NB_LIVES) }

  context "when no guess has been made yet" do
    it "no letter is revealed" do
      expect(engine.progress.values.any?).to be_falsey
    end

    it "player has full lives" do
      expect(engine.lives).to eq TEST_NB_LIVES
    end
  end

  context "when one letter has been rightly guessed" do
    let(:random_letter) { TEST_WORD.chars.to_a.sample }

    before do
      engine.guess(random_letter)
    end

    it "the letter is be marked as revealed" do
      expect(engine.progress[random_letter]).to be_truthy
    end

    it "player has full lives" do
      expect(engine.lives).to eq TEST_NB_LIVES
    end
  end

  context "when one letter has been wrongly guessed" do
    before do
      engine.guess(DUMMY_CHAR)
    end

    it "no letter is not marked as revealed" do
      expect(engine.progress.values.any?).to be_falsey
    end

    it "player lost a life" do
      expect(engine.lives).to eq (TEST_NB_LIVES - 1)
    end
  end

  context "when winning a game" do
    before do
      TEST_WORD.each_char { |char| engine.guess(char) }
    end

    it "all letters are marked as revealed" do
      expect(engine.progress.values.all?).to be_truthy
    end

    it "the game is over" do
      expect(engine.game_over?).to be true
      expect(engine.word_guessed?).to be true
      expect(engine.no_more_life?).to be false
    end

    it "the game is won" do
      expect(engine.win?).to be true
    end
  end

  context "when losing a game" do
    before do
      (TEST_NB_LIVES + 1).times { engine.guess(DUMMY_CHAR) }
    end

    it "not all letters are marked as revealed" do
      expect(engine.progress.values.all?).to be_falsey
    end

    it "the game is over" do
      expect(engine.game_over?).to be true
      expect(engine.word_guessed?).to be false
      expect(engine.no_more_life?).to be true
    end

    it "the game is lose" do
      expect(engine.win?).to be false
    end
  end
end
