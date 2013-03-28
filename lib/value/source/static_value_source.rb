# encoding: UTF-8

module Value
  module Source

    class StaticValueSource < BaseValueSource
      register :static

      attr_reader :value

      # initialize the static value from config, etc.
      def initialize(name, &block)
        @name, @values = name, {}
        instance_eval(&block)
        raise "value required for #{@name}" unless @value
      end
    end

    def value(value)
      @value = value
    end

  end
end