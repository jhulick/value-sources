# encoding: UTF-8

module Value
  # Specification used to process the value source and provides the protocol
  # used by the client interface and the agents.
  class Specification
    include Value::Log

    @@controllers = []
    def self.register(*args, klass)
      @@controllers << [args, klass]
    end

    def initialize(options)
      # TODO implement
    end

    private

    # Process or deliver value sources in the order they are received, so
    # we create a vs queue for each sending vs and process it in this loop.
    #
    # The process loop continues until the queue is empty for this vs, then
    # the queue is deleted.
    #
    # Each vs is wrapped its own Fiber so it can be paused and resumed
    # during asynchronous IO.
    def process_value_queue(jid)
      if @queues[jid].empty?
        @queues.delete(jid)
      else
        @queues[jid].pop do |pair|
          # process_value
        end
      end
    end

    # Create a new controller instance to process the value.
    def process_value(value, klass)
      begin
        klass.new(value, spec).process
      rescue Forbidden
        log.warn("Authorization failed for #{value.name}")
      rescue Exception => e
        log.error("Error processing value: #{e.message}")
      end
    end
  end
end
