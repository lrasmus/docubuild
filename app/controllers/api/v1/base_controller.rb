module Api
  module V1
    class BaseController < ActionController::API
      include Response
      include ExceptionHandler
      
      before_action :authorize_request

      resource_description do
        api_version "1"
      end

      private

      # Check for valid request token and return user
      def authorize_request
        @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
      end
    end
  end
end  