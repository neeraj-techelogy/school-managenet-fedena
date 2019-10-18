require 'test_helper'

class InventoryOrderItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_order_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_order_item" do
    assert_difference('InventoryOrderItem.count') do
      post :create, :inventory_order_item => { }
    end

    assert_redirected_to inventory_order_item_path(assigns(:inventory_order_item))
  end

  test "should show inventory_order_item" do
    get :show, :id => inventory_order_items(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => inventory_order_items(:one).to_param
    assert_response :success
  end

  test "should update inventory_order_item" do
    put :update, :id => inventory_order_items(:one).to_param, :inventory_order_item => { }
    assert_redirected_to inventory_order_item_path(assigns(:inventory_order_item))
  end

  test "should destroy inventory_order_item" do
    assert_difference('InventoryOrderItem.count', -1) do
      delete :destroy, :id => inventory_order_items(:one).to_param
    end

    assert_redirected_to inventory_order_items_path
  end
end
