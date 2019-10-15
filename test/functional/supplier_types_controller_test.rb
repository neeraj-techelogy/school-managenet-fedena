require 'test_helper'

class SupplierTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:supplier_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create supplier_type" do
    assert_difference('SupplierType.count') do
      post :create, :supplier_type => { }
    end

    assert_redirected_to supplier_type_path(assigns(:supplier_type))
  end

  test "should show supplier_type" do
    get :show, :id => supplier_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => supplier_types(:one).to_param
    assert_response :success
  end

  test "should update supplier_type" do
    put :update, :id => supplier_types(:one).to_param, :supplier_type => { }
    assert_redirected_to supplier_type_path(assigns(:supplier_type))
  end

  test "should destroy supplier_type" do
    assert_difference('SupplierType.count', -1) do
      delete :destroy, :id => supplier_types(:one).to_param
    end

    assert_redirected_to supplier_types_path
  end
end
