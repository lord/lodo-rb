require 'bundler/setup'
require 'ffi'
require 'benchmark'

dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)

module Lodo
end

require 'lodo/core'
require 'lodo/string'
