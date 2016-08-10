require 'validators'

describe Hangman::Validator do
  let(:test_word) { "HoRSe" }

  shared_examples "a validator" do
    it "invalidates bad input" do
      expect(validator.validate('1', test_word)).to be_falsey
      expect(validator.validate('%', test_word)).to be_falsey
      expect(validator.validate('aa', test_word)).to be_falsey
      expect(validator.validate('', test_word)).to be_falsey
      expect(validator.validate(nil, test_word)).to be_falsey
    end

    context "when no guess has been made" do
      let(:expected_progress) do
        test_word.each_char.collect{ |char| [char, false] }.to_h
      end

      it "no progress is made" do
        expect(validator.progress(test_word)).to match expected_progress
      end
    end

    context "when a good letter has been guessed" do
      let(:expected_progress) do
        test_word.each_char.collect{ |char| [char, char == 'H'] }.to_h
      end

      it "updates progress" do
        validator.validate('H', test_word)
        expect(validator.progress(test_word)).to match expected_progress
      end

      it "does not update progress twice" do
        validator.validate('H', test_word)
        expect{ validator.validate('H', test_word) }.not_to change { validator.progress(test_word) }
      end
    end

    context "when a bad letter has been guesses" do
      it "does not update progress" do
        expect{ validator.validate('x', test_word) }.not_to change { validator.progress(test_word) }
      end
    end

    context "#word_guessed?" do
      context "when every word's letter has been guessed" do
        it "returns true" do
          allow(validator).to receive(:letter_guessed?).and_return(true)
          expect(validator.word_guessed?(test_word)).to be_truthy
        end
      end

      context "when not every word's letter has been guessed" do
        it "return false" do
          allow(validator).to receive(:letter_guessed?).and_return(false)
          expect(validator.word_guessed?(test_word)).to be_falsey
        end
      end
    end
  end

  shared_examples "a strict validator" do
    it "invalidates wrong letters, no matter the case" do
      expect(validator.validate('x', test_word)).to be_falsey
      expect(validator.validate('X', test_word)).to be_falsey
    end
  end

  describe Hangman::CaseSensitiveValidator do
    let(:validator) { Hangman::CaseSensitiveValidator.new }

    it_behaves_like "a validator"
    it_behaves_like "a strict validator"

    it "validates upper cased letters" do
      expect(validator.letter_guessed?('H')).to be_falsey
      expect(validator.validate('H', test_word)).to be_truthy
      expect(validator.letter_guessed?('H')).to be_truthy
    end

    it "validates lower cases letters" do
      expect(validator.letter_guessed?('o')).to be_falsey
      expect(validator.validate('o', test_word)).to be_truthy
      expect(validator.letter_guessed?('o')).to be_truthy
    end

    it "invalidates wrongly cased letters" do
      expect(validator.validate('r', test_word)).to be_falsey
      expect(validator.letter_guessed?('r')).to be_truthy
      expect(validator.letter_guessed?('R')).to be_falsey

      expect(validator.validate('E', test_word)).to be_falsey
      expect(validator.letter_guessed?('E')).to be_truthy
    end
  end

  describe Hangman::CaseInsensitiveValidator do
    let(:validator) { Hangman::CaseInsensitiveValidator.new }

    it_behaves_like "a validator"
    it_behaves_like "a strict validator"

    it "validates letters no matter the case" do
      expect(validator.validate('H', test_word)).to be_truthy
      expect(validator.letter_guessed?('H')).to be_truthy
      expect(validator.letter_guessed?('h')).to be_truthy

      expect(validator.validate('o', test_word)).to be_truthy
      expect(validator.letter_guessed?('o')).to be_truthy
      expect(validator.letter_guessed?('O')).to be_truthy
    end
  end

  # Neutralized... not relevant for now.

  # describe Hangman::FuzzyValidator do
  #   let (:validator) { Hangman::FuzzyValidator.new(test_word) }

  #   it_behaves_like "a validator"

  #   it "validates the letter before, and after the one given" do
  #     expect(validator.validate('I', test_word)).to be_truthy
  #     expect(validator.letter_guessed?('J', test_word)).to be_truthy
  #   end
  # end
end
