require 'test_helper'

class ExercisesControllerTest < ActionController::TestCase
  setup do
    @exercise = exercises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exercises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exercise" do
    assert_difference('Exercise.count') do
      post :create, :exercise => @exercise.attributes
    end

    assert_redirected_to exercise_path(assigns(:exercise))
  end

  test "should show exercise" do
    get :show, :id => @exercise.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @exercise.to_param
    assert_response :success
  end

  test "should update exercise" do
    put :update, :id => @exercise.to_param, :exercise => @exercise.attributes
    assert_redirected_to exercise_path(assigns(:exercise))
  end

  test "should destroy exercise" do
    assert_difference('Exercise.count', -1) do
      delete :destroy, :id => @exercise.to_param
    end

    assert_redirected_to exercises_path
  end
end
