# encoding: UTF-8

module Value
  module Controller
    class StaticValueController < BaseController
      register :static

      private

      def get
        # forbidden! unless current_user.manage_services?
        # send_result(rows: Value.find_attributes)
      end
    end
  end
end
