require 'test_helper'

class Admin::ProjectsControllerTest < ActionController::TestCase
  setup do
    @admin_project = admin_projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_project" do
    assert_difference('Admin::Project.count') do
      post :create, :admin_project => @admin_project.attributes
    end

    assert_redirected_to admin_project_path(assigns(:admin_project))
  end

  test "should show admin_project" do
    get :show, :id => @admin_project.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @admin_project.to_param
    assert_response :success
  end

  test "should update admin_project" do
    put :update, :id => @admin_project.to_param, :admin_project => @admin_project.attributes
    assert_redirected_to admin_project_path(assigns(:admin_project))
  end

  test "should destroy admin_project" do
    assert_difference('Admin::Project.count', -1) do
      delete :destroy, :id => @admin_project.to_param
    end

    assert_redirected_to admin_projects_path
  end
end
