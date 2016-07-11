require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  setup do
    @article = articles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post :create, article: { created_by_id: @article.created_by_id, deleted_by_id: @article.deleted_by_id, description: @article.description, folder_id: @article.folder_id, status_id: @article.status_id, template_id: @article.template_id, title: @article.title, updated_by_id: @article.updated_by_id, visibility_id: @article.visibility_id }
    end

    assert_redirected_to article_path(assigns(:article))
  end

  test "should show article" do
    get :show, id: @article
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @article
    assert_response :success
  end

  test "should update article" do
    patch :update, id: @article, article: { created_by_id: @article.created_by_id, deleted_by_id: @article.deleted_by_id, description: @article.description, folder_id: @article.folder_id, status_id: @article.status_id, template_id: @article.template_id, title: @article.title, updated_by_id: @article.updated_by_id, visibility_id: @article.visibility_id }
    assert_redirected_to article_path(assigns(:article))
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete :destroy, id: @article
    end

    assert_redirected_to articles_path
  end
end
