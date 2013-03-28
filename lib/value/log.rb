# encoding: UTF-8

module Value
  module Log
    @@logger = nil
    def log
      unless @@logger
        @@logger = Logger.new(STDOUT)
        @@logger.level = Logger::INFO
        @@logger.progname = 'value-sources'
        @@logger.formatter = Class.new(Logger::Formatter) do
          def initialize
            @time = "%Y-%m-%dT%H:%M:%SZ".freeze
            @fmt  = "[%s] %5s -- %s: %s\n".freeze
          end
          def call(severity, time, program, msg)
            @fmt % [time.utc.strftime(@time), severity, program, msg2str(msg)]
          end
        end.new
      end
      @@logger
    end
  end
end
