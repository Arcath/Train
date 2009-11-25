require 'test_helper'

class NavigationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:navigations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create navigation" do
    assert_difference('Navigation.count') do
      post :create, :navigation => { }
    end

    assert_redirected_to navigation_path(assigns(:navigation))
  end

  test "should show navigation" do
    get :show, :id => navigations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => navigations(:one).to_param
    assert_response :success
  end

  test "should update navigation" do
    put :update, :id => navigations(:one).to_param, :navigation => { }
    assert_redirected_to navigation_path(assigns(:navigation))
  end

  test "should destroy navigation" do
    assert_difference('Navigation.count', -1) do
      delete :destroy, :id => navigations(:one).to_param
    end

    assert_redirected_to navigations_path
  end
end
