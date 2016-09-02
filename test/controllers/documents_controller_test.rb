require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  setup do
    @document = documents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:documents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create document" do
    assert_difference('Document.count') do
      post :create, document: { created_by: @document.created_by, deleted_by: @document.deleted_by, description: @document.description, folder_id: @document.folder_id, status_id: @document.status_id, template_id: @document.template_id, title: @document.title, updated_by: @document.updated_by, visibility_id: @document.visibility_id }
    end

    assert_redirected_to document_path(assigns(:document))
  end

  test "should show document" do
    get :show, id: @document
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @document
    assert_response :success
  end

  test "should update document" do
    patch :update, id: @document, document: { created_by: @document.created_by, deleted_by: @document.deleted_by, description: @document.description, folder_id: @document.folder_id, status_id: @document.status_id, template_id: @document.template_id, title: @document.title, updated_by: @document.updated_by, visibility_id: @document.visibility_id }
    assert_redirected_to document_path(assigns(:document))
  end

  test "should destroy document" do
    assert_difference('Document.count', -1) do
      delete :destroy, id: @document
    end

    assert_redirected_to documents_path
  end
end
