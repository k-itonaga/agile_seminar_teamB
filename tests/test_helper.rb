# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'minitest/autorun'
require './src/character'
require './src/hero'
require 'stringio'
require './src/enemy'
require './src/game'
