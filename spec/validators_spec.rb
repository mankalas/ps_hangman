require 'views'

describe Hangman::CaseSensitiveValidator do

  let(:validator) { Hangman::CaseSensitiveValidator.new(TEST_WORD) }

  it "should validate only right cased letters" do
    expect(validator.validate('H')).to be true
    expect(validator.letter_guessed?('H')).to be true
    expect(validator.letter_guessed?('h')).to be false
    expect(validator.validate('o')).to be true
    expect(validator.letter_guessed?('o')).to be true
    expect(validator.letter_guessed?('h')).to be false
    expect(validator.letter_guessed?('O')).to be false
    expect(validator.validate('h')).to be false
    expect(validator.letter_guessed?('h')).to be true
    expect(validator.validate('O')).to be false
    expect(validator.letter_guessed?('h')).to be true
    expect(validator.validate('x')).to be false
  end
end

describe Hangman::CaseInsensitiveValidator do

  let(:validator) { Hangman::CaseInsensitiveValidator.new(TEST_WORD) }

  it "should validate letters no matter the case" do
    expect(validator.validate('H')).to be true
    expect(validator.letter_guessed?('H')).to be true
    expect(validator.letter_guessed?('h')).to be true
    expect(validator.validate('o')).to be true
    expect(validator.letter_guessed?('o')).to be true
    expect(validator.letter_guessed?('O')).to be true
    expect(validator.validate('r')).to be true
    expect(validator.validate('x')).to be false
  end
end
