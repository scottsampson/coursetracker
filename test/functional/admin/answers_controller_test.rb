require 'test_helper'

class Admin::AnswersControllerTest < ActionController::TestCase
  setup do
    @admin_answer = admin_answers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_answers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_answer" do
    assert_difference('Admin::Answer.count') do
      post :create, :admin_answer => @admin_answer.attributes
    end

    assert_redirected_to admin_answer_path(assigns(:admin_answer))
  end

  test "should show admin_answer" do
    get :show, :id => @admin_answer.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @admin_answer.to_param
    assert_response :success
  end

  test "should update admin_answer" do
    put :update, :id => @admin_answer.to_param, :admin_answer => @admin_answer.attributes
    assert_redirected_to admin_answer_path(assigns(:admin_answer))
  end

  test "should destroy admin_answer" do
    assert_difference('Admin::Answer.count', -1) do
      delete :destroy, :id => @admin_answer.to_param
    end

    assert_redirected_to admin_answers_path
  end
end
