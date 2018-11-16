require 'test_helper'

class SectionsControllerTest < ActionController::TestCase
  setup do
    @section = sections(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should create section" do
    assert_difference('Section.count') do
      post :create, params: { section: { document_id: @section.document_id, content: @section.content, created_by_id: @section.created_by_id, deleted_by_id: @section.deleted_by_id, order: @section.order, status_id: @section.status_id, title: @section.title, updated_by_id: @section.updated_by_id, visibility_id: @section.visibility_id } }
    end

    assert_redirected_to section_path(assigns(:section))
  end

  test "should update section" do
    patch :update, params: { id: @section, section: { document_id: @section.document_id, content: @section.content, created_by_id: @section.created_by_id, deleted_by_id: @section.deleted_by_id, order: @section.order, status_id: @section.status_id, title: @section.title, updated_by_id: @section.updated_by_id, visibility_id: @section.visibility_id } }
    assert_redirected_to edit_document_path(assigns(:section).document)
  end

  test "should destroy section" do
    assert_difference('Section.count', -1) do
      delete :destroy, params: { id: @section }
    end

    assert_redirected_to sections_path
  end
end
