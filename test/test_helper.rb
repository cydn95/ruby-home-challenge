require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
Dir.glob('./lib/*.rb', &method(:require))

