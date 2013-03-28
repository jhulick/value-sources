# encoding: UTF-8

module Value
  module Source

    class StaticValueSource < BaseValueSource
      register :static

      attr_reader :value

      # initialize the static value from config, etc.
      def initialize(data)
        puts "StaticVS: #{data}"
        @value = data
      end

      def value(value)
        @value = value
      end

      def process
        @value
      end

    end
  end
end