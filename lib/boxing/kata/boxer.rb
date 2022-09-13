require 'active_support'
require 'active_support/core_ext'

module Boxing
  module Kata
    class Boxer
      
      def initialize(color_counts, contract_effective_date)
        @color_counts = color_counts
        @contract_effective_date = contract_effective_date
        @starter_box_generated = false
      end

      def no_family_preference?
        @color_counts.count == 0
      end

      def generate_starter_box_hashes
        _generate_box_hashes(Box::STARTER_BOX)
      end

      def generate_refill_box_hashes
        _generate_box_hashes(Box::REFILL_BOX)
      end

      private

      def _generate_box_hashes(type)
        boxes = []
        box = nil
        colors = @color_counts.keys
        color = colors[0]
        color_rem_cnt = @color_counts[color]
        index = 0
        box = Box.new(type)
        while(true)
          if box.get_remaining_count == 0
            boxes << box # add complete box to array
            box = Box.new(type) # bring new box to fill up kits
          end
          if color_rem_cnt == 0
            index += 1
            color = colors[index]
            break if color.nil?
            color_rem_cnt = @color_counts[color]
          end
          add_cnt = [box.get_remaining_count, color_rem_cnt].min
          box.add(color, add_cnt)
          color_rem_cnt -= add_cnt
        end
        boxes.map {|box| box.to_hash_with(@contract_effective_date)}
      end

      
    end


    class Box
      STARTER_BOX = "STARTER BOX"
      REFILL_BOX = "REFILL BOX"

      BRUSH_OZ = 9
      PASTE_KIT_OZ = 7.6
      HEADER_OZ = 1

      PRIORITY_CLASS_OZ = 16

      STARTER_BOX_SIZE = 2
      REFILL_BOX_SIZE = 4

      def initialize(type)
        @type = type
        @brushes = []
        @heads = []
        @paste_kit = Kit.new(Kit::PASTE, nil, 0)
      end

      def add(color, count)
        case @type
        when STARTER_BOX
          add_starter_kit(color, count)
        when REFILL_BOX
          add_refill_kit(color, count)
        end
      end

      def add_starter_kit(color, count)
        @brushes << Kit.new(Kit::BRUSH, color, count)
        @heads << Kit.new(Kit::REPLACEMENT_HEAD, color, count)
        @paste_kit.add(count)
      end

      def add_refill_kit(color, count)
        @heads << Kit.new(Kit::REPLACEMENT_HEAD, color, count)
        @paste_kit.add(count)
      end

      def brush_count
        @brushes.inject(0) {|s, kit| s += kit.count}
      end

      def replacement_count
        @heads.inject(0) {|s, kit| s += kit.count}
      end
  
      def get_remaining_count
        case @type
        when STARTER_BOX
          STARTER_BOX_SIZE - brush_count
        when REFILL_BOX
          REFILL_BOX_SIZE - replacement_count
        else
          0
        end
      end

      def weight
        brush_count * BRUSH_OZ + replacement_count * HEADER_OZ + @paste_kit.count * PASTE_KIT_OZ
      end

      def calculate_mail_class
        weight >= PRIORITY_CLASS_OZ ? 'priority' : 'first'
      end

      def calculate_shipping_schedule(contract_effective_date)
        start_date = DateTime.parse(contract_effective_date)
        schedules = []
        case @type
        when STARTER_BOX
          schedules = [start_date.strftime('%Y-%m-%d')]
        when REFILL_BOX
          d = start_date
          new_year_date = Date.new(start_date.year + 1, 1, 1)
          while(d < new_year_date) # repeat per 80 days before new year's day
            schedules << d.strftime('%Y-%m-%d')
            d += 90.days
          end
        end
        schedules
      end

      def to_hash_with(contract_effective_date)
        {
          type: @type,
          brushes: @brushes.map(&:to_hash),
          replacement_heads: @heads.map(&:to_hash),
          paste_kit: @paste_kit.to_hash,
          mail_class: calculate_mail_class,
          schedule: calculate_shipping_schedule(contract_effective_date)
        }
      end

    end

    class Kit
      attr_accessor :type, :color, :count
      BRUSH = :brush
      REPLACEMENT_HEAD = :replacement_head
      PASTE = :PASTE_KIT

      def initialize(type, color, count)
        @type = type
        @color = color
        @count = count
      end

      def add(count)
        @count += count
      end

      def to_hash
        {
          type: type,
          color: color,
          count: count
        }
      end

    end
  end
end
