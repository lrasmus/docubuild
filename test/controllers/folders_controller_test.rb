require 'test_helper'

class FoldersControllerTest < ActionController::TestCase
  setup do
    @folder = folders(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
    skip('Will implement folders in the future')
    get :index
    assert_response :success
    assert_not_nil assigns(:folders)
  end

  test "should get new" do
    skip('Will implement folders in the future')
    get :new
    assert_response :success
  end

  test "should create folder" do
    skip('Will implement folders in the future')
    assert_difference('Folder.count') do
      post :create, params: { folder: { created_by: @folder.created_by, deleted_by: @folder.deleted_by, description: @folder.description, owner: @folder.owner, parent: @folder.parent, status_id: @folder.status_id, title: @folder.title, updated_by: @folder.updated_by, visibility_id: @folder.visibility_id } }
    end

    assert_redirected_to folder_path(assigns(:folder))
  end

  test "should show folder" do
    skip('Will implement folders in the future')
    get :show, id: @folder
    assert_response :success
  end

  test "should get edit" do
    skip('Will implement folders in the future')
    get :edit, id: @folder
    assert_response :success
  end

  test "should update folder" do
    skip('Will implement folders in the future')
    patch :update, params: { id: @folder, folder: { created_by: @folder.created_by, deleted_by: @folder.deleted_by, description: @folder.description, owner: @folder.owner, parent: @folder.parent, status_id: @folder.status_id, title: @folder.title, updated_by: @folder.updated_by, visibility_id: @folder.visibility_id } }
    assert_redirected_to folder_path(assigns(:folder))
  end

  test "should destroy folder" do
    skip('Will implement folders in the future')
    assert_difference('Folder.count', -1) do
      delete :destroy, params: { id: @folder }
    end

    assert_redirected_to folders_path
  end
end
