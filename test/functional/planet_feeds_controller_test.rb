require 'test_helper'

class PlanetFeedsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:planet_feeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create planet_feed" do
    assert_difference('PlanetFeed.count') do
      post :create, :planet_feed => { }
    end

    assert_redirected_to planet_feed_path(assigns(:planet_feed))
  end

  test "should show planet_feed" do
    get :show, :id => planet_feeds(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => planet_feeds(:one).to_param
    assert_response :success
  end

  test "should update planet_feed" do
    put :update, :id => planet_feeds(:one).to_param, :planet_feed => { }
    assert_redirected_to planet_feed_path(assigns(:planet_feed))
  end

  test "should destroy planet_feed" do
    assert_difference('PlanetFeed.count', -1) do
      delete :destroy, :id => planet_feeds(:one).to_param
    end

    assert_redirected_to planet_feeds_path
  end
end
