# encoding: UTF-8

module Value
  module Controller
    class BaseController
      include Value::Log

      def self.register(*args)
        Specification.register(*args, self)
      end

      attr_reader :value

      def initialize(value)
        @value = value
        @current_user = nil
      end

      def process
        # must be addressed to component, not a service
        return unless to_component?
        if value.get?
          get
        elsif value.set? && value.elements.first['action'] == 'delete'
          delete
        elsif value.set?
          save
        end
      rescue Forbidden
        raise
      rescue
        send_error('not-acceptable')
      end

      private

      def get
        send_error('feature-not-implemented')
      end

      def save
        send_error('feature-not-implemented')
      end

      def delete
        send_error('feature-not-implemented')
      end

      def send_result(obj=nil)

      end

      def send_error(condition, obj=nil)

      end

      def forbidden!
        raise Forbidden
      end

      # Return the User object for the user that sent this session. Useful for
      # permission authorization checks before performing server actions.
      def current_user
        #token = node.from.stripped.to_s.downcase
        #@current_user ||= User.find_by_token(token)
      end
    end
  end
end
