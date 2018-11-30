require 'test_helper'

class AuthorizeApiRequestTest < ActiveSupport::TestCase
  include TokenTestHelper

  setup do
    @user = users(:one)
  end

  test "returns user object when valid request" do
    result = AuthorizeApiRequest.new({ 'Authorization' => token_generator(@user.id) }).call
    assert_equal(result[:user], @user)
  end

  test "raises a MissingToken error when missing token" do
    assert_raises ExceptionHandler::MissingToken do
     AuthorizeApiRequest.new({}).call
   end
  end

  test "raises an InvalidToken error when token is generated from unknown user" do
    assert_raises ExceptionHandler::InvalidToken do
     AuthorizeApiRequest.new({'Authorization' => token_generator(5)}).call
   end
  end

  test "raises an InvalidToken error when token is expired" do
    assert_raises ExceptionHandler::InvalidToken do
     AuthorizeApiRequest.new({'Authorization' => expired_token_generator(@user.id)}).call
   end
  end

  test "raises an InvalidToken error when token is not valid JWT" do
    assert_raises ExceptionHandler::InvalidToken do
      AuthorizeApiRequest.new({'Authorization' => 'thisisinvalid'}).call
    end
  end
end