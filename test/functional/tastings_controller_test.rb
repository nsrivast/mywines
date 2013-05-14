require 'test_helper'

class TastingsControllerTest < ActionController::TestCase
  setup do
    @tasting = tastings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tastings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tasting" do
    assert_difference('Tasting.count') do
      post :create, tasting: { adjs_aftertaste: @tasting.adjs_aftertaste, adjs_aroma: @tasting.adjs_aroma, adjs_taste: @tasting.adjs_taste, color: @tasting.color, drank_after: @tasting.drank_after, drank_again: @tasting.drank_again, drank_on: @tasting.drank_on, drank_with: @tasting.drank_with, rating_final: @tasting.rating_final, rating_first: @tasting.rating_first, trait_acidity: @tasting.trait_acidity, trait_alcohol: @tasting.trait_alcohol, trait_astringency: @tasting.trait_astringency, trait_body: @tasting.trait_body, trait_intensity: @tasting.trait_intensity, trait_sweetness: @tasting.trait_sweetness, user_id: @tasting.user_id, wine_id: @tasting.wine_id }
    end

    assert_redirected_to tasting_path(assigns(:tasting))
  end

  test "should show tasting" do
    get :show, id: @tasting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tasting
    assert_response :success
  end

  test "should update tasting" do
    put :update, id: @tasting, tasting: { adjs_aftertaste: @tasting.adjs_aftertaste, adjs_aroma: @tasting.adjs_aroma, adjs_taste: @tasting.adjs_taste, color: @tasting.color, drank_after: @tasting.drank_after, drank_again: @tasting.drank_again, drank_on: @tasting.drank_on, drank_with: @tasting.drank_with, rating_final: @tasting.rating_final, rating_first: @tasting.rating_first, trait_acidity: @tasting.trait_acidity, trait_alcohol: @tasting.trait_alcohol, trait_astringency: @tasting.trait_astringency, trait_body: @tasting.trait_body, trait_intensity: @tasting.trait_intensity, trait_sweetness: @tasting.trait_sweetness, user_id: @tasting.user_id, wine_id: @tasting.wine_id }
    assert_redirected_to tasting_path(assigns(:tasting))
  end

  test "should destroy tasting" do
    assert_difference('Tasting.count', -1) do
      delete :destroy, id: @tasting
    end

    assert_redirected_to tastings_path
  end
end
