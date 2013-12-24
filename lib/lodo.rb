require 'bundler/setup'
require 'ffi'
require 'benchmark'

dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)

module Lodo
end

USE_SIMULATOR = false unless defined? USE_SIMULATOR

# todo remove
USE_SIMULATOR = true

if USE_SIMULATOR
  require 'lodo/core_simulator'
  Lodo::Core = Lodo::CoreSimulator
else
  require 'lodo/core'
end

require 'lodo/string'
require 'lodo/board'
