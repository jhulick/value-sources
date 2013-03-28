# encoding: UTF-8

module Value

  class ValueSource

    attr_reader :data, :params
    attr_reader :klass

    def initialize(name, &block)
      instance_eval(&block)
      raise "value required for #{@name}" unless @data
      raise "klass required for #{@name}" unless @klass
      #raise "must define at least one application" if @applications.empty?
    end

    def value(value)
      @data = value
    end

    # TODO: Create a new controller instance to process the value source.
    def process
      begin
        Object.const_get('Value').const_get('Source').const_get(@klass).new(@data, @params).process
      rescue Forbidden
        #log.warn("Authorization failed for #{klass}")
        puts "Authorization failed for #{klass}"
      rescue Exception => e
        #log.error("Error processing value source: #{e.message}")
        puts "Error processing value source: #{e.message}"
      end
    end

    def klass(klass)
      @klass = klass
    end

    def specification(spec)

    end

    def params(params)
      @params = params
    end

  end
end
