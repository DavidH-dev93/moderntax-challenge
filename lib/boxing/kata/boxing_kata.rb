require "boxing/kata/version"

module Boxing
  module Kata

    def self.report
      unless has_input_file?
        puts "Usage: ./bin/boxing-kata << spec/fixtures/family_preferences.csv"
      end

      # Starting point for your code...
    end

    def self.has_input_file?
      ARGF.filename != "-"
    end
  end
end
