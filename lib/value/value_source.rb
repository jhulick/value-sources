# encoding: UTF-8

module Value

  class ValueSource

    attr_reader :data

    def initialize(name, &block)
      instance_eval(&block)
      raise "value required for #{@name}" unless @data
      #raise "must define at least one application" if @applications.empty?
    end

    def value(value)
      # calculate value
      @data = value
    end

    def klass(klass)

    end

    def specification(spec)

    end

    def params(params)

    end

  end
end
