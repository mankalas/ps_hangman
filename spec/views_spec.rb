require 'views'

describe Hangman::ConsoleView do

  let(:view) { Hangman::ConsoleView.new }

  it "should sanitize user's input" do
    view = Hangman::ConsoleView.new(nil)
    expect(view.input_sane? "a").to be true
    expect(view.input_sane? "A").to be true
    expect(view.input_sane? "1").to be false
    expect(view.input_sane? "aa").to be false
    expect(view.input_sane? "#").to be false
  end
end
