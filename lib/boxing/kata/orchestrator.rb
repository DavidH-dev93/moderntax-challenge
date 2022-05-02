require 'tty-prompt'
require 'boxing/kata/csv_parser'
require 'boxing/kata/boxer'
require 'boxing/kata/box_printer'

module Boxing
  module Kata
    class Orchestrator
      def self.run(filepath)
        prompt = TTY::Prompt.new
        puts 'Welcome to the Beam Ruby Kata! What would you like to do?'

        loop do
          choices = [
            { name: 'Load Brush Preferences', value: 1 },
            { name: 'Print Starter Boxes', value: 2 },
            { name: 'Print Refill Boxes', value: 3 },
            { name: 'Exit', value: 4 },
          ]

          user_input = prompt.select('Please select an option below...', choices)
          case user_input
          when 1
            parser = CsvParser.new(filepath)
            @boxer = Boxer.new(parser.extract_color_counts, parser.extract_contract_effective_date)
          when 2
            if @boxer.nil?
              puts 'Preferences must be loaded before boxes can be generated!'
              next
            end
            box_hashes = @boxer.generate_starter_box_hashes
            BoxPrinter.print_boxes(box_hashes)
          when 3
            if @boxer.nil?
              puts 'Preferences must be loaded before boxes can be generated!'
              next
            end
            box_hashes = @boxer.generate_refill_box_hashes
            BoxPrinter.print_boxes(box_hashes)
          when 4
            puts 'Quitting! Goodbye!'
            exit(0)
          end
        end
      end
    end
  end
end
