module Api
  module V1
    class AuthenticationController < Api::V1::BaseController
      skip_before_action :authorize_request, only: :authenticate
      respond_to :json

      # return auth token once user is authenticated
      def authenticate
        auth_params = normalize_auth_params
        auth_token = get_auth_token(auth_params[:email], auth_params[:password])
        if auth_token.blank?
          json_response({message: 'Username or password is incorrect'}, :unauthorized)
        else
          json_response({jwt: auth_token}, :created)
        end
      end

      private

        def normalize_auth_params
          allowed_params = params.permit(:email, :password, :auth => [:email, :password])
          unless allowed_params[:auth].nil?
            params = allowed_params[:auth]
          else
            allowed_params
          end
        end

        def get_auth_token email, password
          user = User.find_by(email: email)
          return JsonWebToken.encode(user_id: user.id) if user && user.valid_password?(password)
          nil
        end
    end
  end
end