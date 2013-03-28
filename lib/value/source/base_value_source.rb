# encoding: UTF-8

module Value
  module Source

    # The base class for various value sources (script, text, list, static),
    # containing a single value or a list of values.
    class BaseValueSource
      include Value::Log

      BLANK_STRING = ''.freeze

      attr_reader   :specification, :text_value, :text_value_or_blank, :text_values, :presentation_item
      attr_accessor :user

      @@types = {}

      def self.register(name, vs={})
        @@types[[name, vs]] = self
      end

      @@value_sources = []
      def self.register(*args, klass)
        @@value_sources << [args, klass]
      end

      def initialize(specification)
        @specification = specification
      end

      def post_init
        # post processing
      end

      # Initialize a new ValueSource expression parser. This is called when the
      # application is first started as well as for stream restarts during
      # development or dynamic loading.
      def create_parser
        @parser = Parser.new.tap do |p|
          # some parser
        end
      end

      def reset
        create_parser
      end

      def send_error(condition, obj=nil)
        puts "#{condition}"
      end

    end
  end
end