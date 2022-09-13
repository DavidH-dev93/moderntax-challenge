require 'csv'

module Boxing
  module Kata
    class InvalidCsvFileError < StandardError
      def initialize(msg='')
        super("Invalid CSV file error - #{msg}")
      end
    end

    class CsvParser
      def initialize(filepath)
        @filepath = filepath
        @csv_contents = CSV.read(@filepath, :headers=>true)
      end

      def no_family_preference?
        @csv_contents.count == 0
      end

      def extract_color_counts
        color_counts = @csv_contents['brush_color'].inject(Hash.new(0)) {|h, color| h[color] +=1; h}
        throw InvalidCsvFileError('No color preference specified') if color_counts.keys == [nil]
        color_counts
      end

      def extract_contract_effective_date
        contract_date = @csv_contents['contract_effective_date'][0] 
        throw InvalidCsvFileError('No contract effective date specified') if contract_date.nil?
        contract_date
      end
    end
  end
end
