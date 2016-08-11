require 'hangman'
require 'views'

describe Hangman::Game do

  let(:view) { double("Hangman::View") }
  let(:engine) { double("Hangman::Engine") }
  let(:game) { Hangman::Game.new }
  let(:runs) { 3 }

  it "runs a game until it's over" do
    expect(view).to receive(:welcome).once
    expect(view).to receive(:show_state).exactly(runs).times
    expect(view).to receive(:ask_guess).and_return('%').exactly(runs).times
    expect(view).to receive(:input_sane?).and_return(true).exactly(runs).times
    expect(view).to receive(:game_over).once

    expect(engine).to receive(:game_over?).at_least(:once).and_return(false, false, false, true) # is at_least useful here? .exactly(4).times?
    expect(engine).to receive(:guess).at_least(:once)

    game.run(engine: engine, view: view)
  end
end
