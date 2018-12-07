require 'test_helper'

class AuthenticationControllerTest < ActionController::TestCase
  include TokenTestHelper

  setup do
    @controller = Api::V1::AuthenticationController.new
    @user = users(:api_user)
  end

  test "should authenticate a valid user" do
    post :authenticate, params: { email: @user.email, password: "password123" }
    assert_response :success
    assert_not @response.body["auth_token"].nil?
  end

  test "should authenticate a valid user using legacy params" do
    post :authenticate, params: { auth: { email: @user.email, password: "password123" } }
    assert_response :success
    assert_not @response.body["auth_token"].nil?
  end

  test "should fail to authenticate a valid user with the wrong password" do
    post :authenticate, params: { email: @user.email, password: "password1234" }
    assert_response :unauthorized
    assert_not @response.body["message"].nil?
    assert @response.body["auth_token"].nil?
  end

  test "should fail to authenticate an unknown user" do
    post :authenticate, params: { email: "nobody@test.com", password: "password1234" }
    assert_response :unauthorized
    assert_not @response.body["message"].nil?
    assert @response.body["auth_token"].nil?
  end
end