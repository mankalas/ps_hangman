require 'hangman'
require 'views'

describe Hangman::Game do

  let(:view) { double("Hangman::View") }
  let(:engine) { double("Hangman::Engine") }
  let(:game) { Hangman::Game.new }

  it "runs a game until it's over" do
    allow(view).to receive(:ask_guess).and_return('%')
    allow(view).to receive(:input_sane?).and_return(true)
    expect(view).to receive(:welcome).once
    expect(view).to receive(:show_state).at_least(:once)
    expect(view).to receive(:ask_guess).at_least(:once)
    expect(view).to receive(:input_sane?).at_least(:once)
    expect(view).to receive(:game_over).once

    allow(engine).to receive(:game_over?).and_return(false, false, false, true)
    expect(engine).to receive(:game_over?).at_least(:once)
    expect(engine).to receive(:guess).at_least(:once)

    game.run(engine: engine, view: view)
  end
end
