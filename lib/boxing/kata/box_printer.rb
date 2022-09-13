module Boxing
  module Kata
    class BoxPrinter
      @@output = $stdout
      def self.print_boxes(box_hashes)
        box_hashes.each do |box|
          print_box_contents(box)
          print_box_mail_class(box)
          print_box_shipping_schedule(box)
          @@output.print("\n")
        end
      end

      private

      def self.print_box_contents(box)
        result = "#{box[:type]}\n"
        box[:brushes].each do |h|
          result += "#{h[:count]} #{h[:color]} #{_generate_plural_word("brush", h[:count])}\n"
        end
        box[:replacement_heads].each do |h|
          result += "#{h[:count]} #{h[:color]} #{_generate_plural_word("replacement heads", h[:count])}\n"
        end
        result += "#{box[:paste_kit][:count]} #{_generate_plural_word("paste kit", box[:paste_kit][:count])}\n"
        @@output.print result
        
      end

      def self.print_box_mail_class(box)
        @@output.print "Mail class: #{box[:mail_class]}\n"
      end

      def self.print_box_shipping_schedule(box)
        @@output.print "Schedule: #{box[:schedule].join(', ')}\n"
      end

      # We can use String.pluralize function in active_support
      def self._generate_plural_word(word, count)
        count > 1 ? word.pluralize : word
        return "#{word}es" if word == "brush" && count > 1
        return "#{word}s" if count > 1
        word
      end
    end
  end
end
