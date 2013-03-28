# encoding: UTF-8

module Value
  # A Config object is passed to value sources to give them access
  # to configuration information like application, types, parameters,
  # etc. This class provides the DSL methods used in the conf/config.rb file.
  class Config
    LOG_LEVELS = %w[debug info warn error fatal].freeze

    attr_reader :applications

    @@instance = nil
    def self.configure(&block)
      @@instance = self.new(&block)
    end

    def self.instance
      @@instance
    end

    def self.register(application, name, &block)
      @applications[application].register(name, &block)
    end

    def initialize(&block)
      @applications = {}
      instance_eval(&block)
      raise "must define at least one application" if @applications.empty?
    end

    def application(*names, &block)
      names = names.flatten.map {|name| name.downcase }
      dupes = names.uniq.size != names.size || (@applications.keys & names).any?
      raise "one application definition per domain allowed" if dupes
      names.each do |name|
        @applications[name] = Application.new(name, &block)
      end
    end

    def log(level)
      const = Logger.const_get(level.to_s.upcase) rescue nil
      unless LOG_LEVELS.include?(level.to_s) && const
        raise "log level must be one of: #{LOG_LEVELS.join(', ')}"
      end
      log = Class.new.extend(Value::Log).log
      log.progname = 'value-service'
      log.level = const
    end

    def applications
      @applications
    end

    class Application
      attr_reader :name
      attr_reader :values

      @@values = {}
      def self.register(*args, klass, application)
        @@values[application] = [args, klass]
      end

      def register(application, name, &block)
        @applications[application].register(name, &block)
      end

      def initialize(name, &block)
        @name, @values = name, {}
        instance_eval(&block)
        raise "must define at least one value source" if @values.empty?
      end

      def value_source(*names, &block)
        names = names.flatten.map {|name| name.downcase }
        dupes = names.uniq.size != names.size || (@values.keys & names).any?
        raise "one unique value source per application allowed" if dupes
        names.each do |name|
          @values[name] = ValueSource.new(name, &block)
        end
      end

    end
  end
end
