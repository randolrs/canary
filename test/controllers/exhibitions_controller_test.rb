require 'test_helper'

class ExhibitionsControllerTest < ActionController::TestCase
  setup do
    @exhibition = exhibitions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exhibitions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exhibition" do
    assert_difference('Exhibition.count') do
      post :create, exhibition: { address_line_1: @exhibition.address_line_1, address_line_2: @exhibition.address_line_2, city_id: @exhibition.city_id, country: @exhibition.country, end_date: @exhibition.end_date, start_date: @exhibition.start_date, state_or_province: @exhibition.state_or_province, user_id: @exhibition.user_id, venue_name: @exhibition.venue_name, zip_or_postal_code: @exhibition.zip_or_postal_code }
    end

    assert_redirected_to exhibition_path(assigns(:exhibition))
  end

  test "should show exhibition" do
    get :show, id: @exhibition
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @exhibition
    assert_response :success
  end

  test "should update exhibition" do
    patch :update, id: @exhibition, exhibition: { address_line_1: @exhibition.address_line_1, address_line_2: @exhibition.address_line_2, city_id: @exhibition.city_id, country: @exhibition.country, end_date: @exhibition.end_date, start_date: @exhibition.start_date, state_or_province: @exhibition.state_or_province, user_id: @exhibition.user_id, venue_name: @exhibition.venue_name, zip_or_postal_code: @exhibition.zip_or_postal_code }
    assert_redirected_to exhibition_path(assigns(:exhibition))
  end

  test "should destroy exhibition" do
    assert_difference('Exhibition.count', -1) do
      delete :destroy, id: @exhibition
    end

    assert_redirected_to exhibitions_path
  end
end
