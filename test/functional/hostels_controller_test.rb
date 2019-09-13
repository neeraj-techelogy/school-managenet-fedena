require 'test_helper'

class HostelsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hostels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hostel" do
    assert_difference('Hostel.count') do
      post :create, :hostel => { }
    end

    assert_redirected_to hostel_path(assigns(:hostel))
  end

  test "should show hostel" do
    get :show, :id => hostels(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hostels(:one).to_param
    assert_response :success
  end

  test "should update hostel" do
    put :update, :id => hostels(:one).to_param, :hostel => { }
    assert_redirected_to hostel_path(assigns(:hostel))
  end

  test "should destroy hostel" do
    assert_difference('Hostel.count', -1) do
      delete :destroy, :id => hostels(:one).to_param
    end

    assert_redirected_to hostels_path
  end
end
