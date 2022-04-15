module Boxing
  module Kata
    class BoxPrinter
      def self.print_boxes(box_hashes)
        box_hashes.each do |box|
          print_box_contents(box)
          print_box_mail_class(box)
          print_box_shipping_schedule(box)
        end
      end

      private

      def print_box_contents(box)

      end

      def print_box_mail_class(box)

      end

      def print_box_shipping_schedule(box)

      end
    end
  end
end
