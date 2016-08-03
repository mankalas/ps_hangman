#!/usr/bin/env ruby

require 'optparse'

require 'hangman'

options = {}

optparse = OptionParser.new do |opts|
  opts.banner = "Usage: hangman_exe [options]"

  options[:lives] = 5
  opts.on('-l', '--lives N', 'Number of lives') do |nb_lives|
    options[:lives] = nb_lives.to_i
  end

  options[:mode] = :normal
  opts.on('-d', '--drugs', 'Enable LSD mode') do
    options[:mode] = :lsd
  end

  opts.on('-h', '--help', 'You are reading it') do
    puts opts
    exit
  end
end

optparse.parse!
p options

game = Hangman::Game.new(lives: options[:lives],
                         mode: options[:mode])
game.run
