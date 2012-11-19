require 'test_helper'

class ErrorTypesControllerTest < ActionController::TestCase
  setup do
    @error_type = error_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:error_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create error_type" do
    assert_difference('ErrorType.count') do
      post :create, error_type: @error_type.attributes
    end

    assert_redirected_to error_type_path(assigns(:error_type))
  end

  test "should show error_type" do
    get :show, id: @error_type.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @error_type.to_param
    assert_response :success
  end

  test "should update error_type" do
    put :update, id: @error_type.to_param, error_type: @error_type.attributes
    assert_redirected_to error_type_path(assigns(:error_type))
  end

  test "should destroy error_type" do
    assert_difference('ErrorType.count', -1) do
      delete :destroy, id: @error_type.to_param
    end

    assert_redirected_to error_types_path
  end
end
