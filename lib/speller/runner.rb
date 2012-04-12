$: << File.dirname(File.dirname(__FILE__))

require 'speller'
require 'speller/parser'

module Speller
  class Runner
    def initialize
      puts "ARGV is currently #{ARGV.inspect}"
      parser = Parser.new ARGV.first
      parser.parse
    end
  end
end

Speller::Runner.new