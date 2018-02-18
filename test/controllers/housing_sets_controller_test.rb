require 'test_helper'

class HousingSetsControllerTest < ActionController::TestCase
  setup do
    @housing_set = housing_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:housing_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create housing_set" do
    assert_difference('HousingSet.count') do
      post :create, housing_set: { district: @housing_set.district, name: @housing_set.name }
    end

    assert_redirected_to housing_set_path(assigns(:housing_set))
  end

  test "should show housing_set" do
    get :show, id: @housing_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @housing_set
    assert_response :success
  end

  test "should update housing_set" do
    patch :update, id: @housing_set, housing_set: { district: @housing_set.district, name: @housing_set.name }
    assert_redirected_to housing_set_path(assigns(:housing_set))
  end

  test "should destroy housing_set" do
    assert_difference('HousingSet.count', -1) do
      delete :destroy, id: @housing_set
    end

    assert_redirected_to housing_sets_path
  end
end
