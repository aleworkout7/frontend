require 'test_helper'

class PrediosControllerTest < ActionController::TestCase
  setup do
    @predio = predios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:predios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create predio" do
    assert_difference('Predio.count') do
      post :create, predio: { address: @predio.address, details: @predio.details, name: @predio.name }
    end

    assert_redirected_to predio_path(assigns(:predio))
  end

  test "should show predio" do
    get :show, id: @predio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @predio
    assert_response :success
  end

  test "should update predio" do
    patch :update, id: @predio, predio: { address: @predio.address, details: @predio.details, name: @predio.name }
    assert_redirected_to predio_path(assigns(:predio))
  end

  test "should destroy predio" do
    assert_difference('Predio.count', -1) do
      delete :destroy, id: @predio
    end

    assert_redirected_to predios_path
  end
end
