require 'boxing/kata/version'

module Boxing
  module Kata

    def self.report
      puts 'Usage: ruby ./bin/boxing-kata spec/fixtures/family_preferences.csv' unless input_file?
      # Starting point for your code...
    end

    def self.input_file?
      return false unless ARGV[0]

      File.exist?(ARGV[0])
    end
  end
end
