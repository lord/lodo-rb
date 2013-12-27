require 'bundler/setup'
require 'ffi'
require 'benchmark'

dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)

module Lodo
end

LODO_MODE = :hardware unless defined? LODO_MODE

if ARGV.include?("--server") || LODO_MODE == :server
  require 'lodo/core_simulator'
  Lodo::Core = Lodo::CoreSimulator
  Lodo::CoreSimulator.start_server
elsif ARGV.include?("--simulator") || LODO_MODE == :simulator
  require 'lodo/core_simulator'
  Lodo::Core = Lodo::CoreSimulator
elsif ARGV.include?("--hardware") || LODO_MODE == :hardware
  require 'lodo/core'
else
  raise "Unknown Lodo mode"
end

require 'lodo/string'
require 'lodo/board'
