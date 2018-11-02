require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  setup do
    @document = documents(:in_progress)
    @user = users(:one)
    sign_in @user
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
      post :create, params: { document: { created_by_id: @document.created_by_id, deleted_by_id: @document.deleted_by_id, description: @document.description, folder_id: @document.folder_id, status_id: @document.status_id, template_id: @document.template_id, title: @document.title, updated_by_id: @document.updated_by_id, visibility_id: @document.visibility_id } }
    end

    assert_redirected_to edit_document_path(assigns(:document))
  end

  test "should show document" do
    get :show, params: { id: @document }
    assert_response :success
  end

  test "should redirect invalid document" do
    get :show, params: { id: 9999999 }
    assert_redirected_to documents_path
  end

  test "should get edit" do
    get :edit, params: { id: @document }
    assert_response :success
  end

  test "should update document" do
    patch :update, params: { id: @document, document: { created_by_id: @document.created_by_id, deleted_by_id: @document.deleted_by_id, description: @document.description, folder_id: @document.folder_id, status_id: @document.status_id, template_id: @document.template_id, title: @document.title, updated_by_id: @document.updated_by_id, visibility_id: @document.visibility_id } }
    assert_redirected_to edit_document_path(assigns(:document))
  end

  test "should destroy document" do
    assert_difference('Document.count', -1) do
      delete :destroy, params: { id: @document }
    end

    assert_redirected_to documents_path
  end
end
