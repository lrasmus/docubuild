require 'test_helper'

class DocumentationControllerTest < ActionController::TestCase
  include TokenTestHelper

  setup do
    @controller = Api::V1::DocumentsController.new
    @user = users(:api_user)
  end

  test "should return documents for an authenticated user" do
    request.env["HTTP_AUTHORIZATION"] =  "Bearer #{token_generator(@user.id)}"
    get :index, params: {}
    assert_response :success
  end

  test "should return unprocessable_entity for an invalid user" do
    request.env["HTTP_AUTHORIZATION"] =  "Bearer #{token_generator(-1)}"
    get :index, params: {}, as: :json
    assert_response :unprocessable_entity
  end

  test "should return single document belonging to an authenticated user" do
    request.env["HTTP_AUTHORIZATION"] =  "Bearer #{token_generator(@user.id)}"
    get :show, params: {:id => documents(:api_user_document).id}
    assert_response :success
  end

  test "should return not return a specific document belonging to another user" do
    request.env["HTTP_AUTHORIZATION"] =  "Bearer #{token_generator(@user.id)}"
    get :show, params: {:id => documents(:published_private).id}
    assert_response :not_found
  end

  test "should return a specific public document belonging to another user" do
    request.env["HTTP_AUTHORIZATION"] =  "Bearer #{token_generator(@user.id)}"
    get :show, params: {:id => documents(:published_public).id}
    assert_response :success
  end
end