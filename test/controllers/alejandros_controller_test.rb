require 'test_helper'

class AlejandrosControllerTest < ActionController::TestCase
  setup do
    @alejandro = alejandros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alejandros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alejandro" do
    assert_difference('Alejandro.count') do
      post :create, alejandro: { due_date: @alejandro.due_date, email: @alejandro.email, id_member: @alejandro.id_member, message: @alejandro.message, payment: @alejandro.payment, payment_date: @alejandro.payment_date }
    end

    assert_redirected_to alejandro_path(assigns(:alejandro))
  end

  test "should show alejandro" do
    get :show, id: @alejandro
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alejandro
    assert_response :success
  end

  test "should update alejandro" do
    patch :update, id: @alejandro, alejandro: { due_date: @alejandro.due_date, email: @alejandro.email, id_member: @alejandro.id_member, message: @alejandro.message, payment: @alejandro.payment, payment_date: @alejandro.payment_date }
    assert_redirected_to alejandro_path(assigns(:alejandro))
  end

  test "should destroy alejandro" do
    assert_difference('Alejandro.count', -1) do
      delete :destroy, id: @alejandro
    end

    assert_redirected_to alejandros_path
  end
end
