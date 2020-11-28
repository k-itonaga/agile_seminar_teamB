# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../src', __dir__)
Dir["./src/*.rb"].each {|file| require file }

require 'minitest/autorun'
require 'stringio'
