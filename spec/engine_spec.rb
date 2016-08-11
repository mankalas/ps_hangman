require 'engine'

DUMMY_CHAR = '@'

describe Hangman::Engine do

  let(:word) { "HoRSe" }
  let(:lives) { 5 }
  let(:validator) { instance_double(Hangman::Validator) }
  let(:engine) { Hangman::Engine.new(word: word,
                                     lives: lives,
                                     validator: validator) }
  describe "#progress" do
    it "returns the validator's progress" do
      expect(validator).to receive(:progress).with(word).and_return(:progress_hash)
      expect(engine.progress).to eq :progress_hash
    end
  end

  describe"#guess" do
    context "when no guess has been made yet" do
      it "player has full lives" do
        expect(engine.lives).to eq lives
      end
    end

    context "when one letter has been rightly guessed" do
      it "player does not lose any life" do
        expect(validator).to receive(:validate).and_return(true)
        expect{ engine.guess('H') }.not_to change { engine.lives }
      end
    end

    context "when one letter has been wrongly guessed" do
      it "player loses a life" do
        expect(validator).to receive(:validate).and_return(false)
        expect{ engine.guess('x') }.to change { engine.lives }.by(-1)
      end
    end
  end

  context "when the word has been guessed" do
    before do
      expect(validator).to receive(:word_guessed?).and_return(true)
    end

    it "is over" do
      expect(engine.game_over?).to be_truthy
    end

    it "has been won" do
      expect(engine.win?).to be_truthy
    end
  end

  context "when all lives have been lost" do
    before do
      expect(engine).to receive(:no_more_life?).and_return(true)
      expect(validator).to receive(:word_guessed?).and_return(false)
    end

    it "is over" do
      expect(engine.game_over?).to be_truthy
    end

    it "has been lost" do
      expect(engine.win?).to be_falsey
    end
  end
end
