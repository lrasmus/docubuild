# With credit and thanks to: https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-two
class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  # Service entry point - return valid user object
  def call
    { user: user }
  end

  private

  attr_reader :headers

  def user
    # Check if user is in the database
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
  rescue ActiveRecord::RecordNotFound => e
    # Handle user not found
    raise(ExceptionHandler::InvalidToken, "Invalid token: #{e.message}")
  end

  # decode authentication token
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  # check for token in `Authorization` header
  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    end
    raise(ExceptionHandler::MissingToken, 'Missing token')
  end
end