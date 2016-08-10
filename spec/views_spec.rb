require 'views'

describe Hangman::ConsoleView do

  let(:engine) { double("Hangman::Engine") }
  let(:view) { Hangman::ConsoleView.new(engine: engine) }
  let(:progress) { {'a' => true, 'b' => false } }
  let(:lives) { 42 }
  let(:expected_state) { "a_ (%s lives remaining)" % lives }

  it "#input_sane?" do
    expect(view.input_sane?("a")).to be_truthy
    expect(view.input_sane?("A")).to be_truthy
    expect(view.input_sane?("1")).to be_falsey
    expect(view.input_sane?("aa")).to be_falsey
    expect(view.input_sane?("#")).to be_falsey
    expect(view.input_sane?(nil)).to be_falsey
    expect(view.input_sane?('')).to be_falsey
  end

  it "#build_state_message" do
    allow(engine).to receive(:progress).and_return(progress)
    allow(engine).to receive(:lives).and_return(lives)
    expect(engine).to receive(:progress).once
    expect(engine).to receive(:lives).once
    expect(view.build_state_message).to eq expected_state
  end

  it "#build_game_over_message" do
    expect(engine).to receive(:win?).once
    expect(engine).to receive(:word).once
    view.build_game_over_message
  end

  it "#build_lost_message" do
    expect(engine).to receive(:word).once
    view.build_lost_message
  end
end
