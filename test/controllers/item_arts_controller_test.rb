require 'test_helper'

class ItemArtsControllerTest < ActionController::TestCase
  setup do
    @item_art = item_arts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_arts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_art" do
    assert_difference('ItemArt.count') do
      post :create, item_art: { description: @item_art.description, height: @item_art.height, length: @item_art.length, name: @item_art.name, price: @item_art.price, search_code: @item_art.search_code, user_id: @item_art.user_id, venue_id: @item_art.venue_id, width: @item_art.width }
    end

    assert_redirected_to item_art_path(assigns(:item_art))
  end

  test "should show item_art" do
    get :show, id: @item_art
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_art
    assert_response :success
  end

  test "should update item_art" do
    patch :update, id: @item_art, item_art: { description: @item_art.description, height: @item_art.height, length: @item_art.length, name: @item_art.name, price: @item_art.price, search_code: @item_art.search_code, user_id: @item_art.user_id, venue_id: @item_art.venue_id, width: @item_art.width }
    assert_redirected_to item_art_path(assigns(:item_art))
  end

  test "should destroy item_art" do
    assert_difference('ItemArt.count', -1) do
      delete :destroy, id: @item_art
    end

    assert_redirected_to item_arts_path
  end
end
