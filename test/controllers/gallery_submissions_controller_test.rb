require 'test_helper'

class GallerySubmissionsControllerTest < ActionController::TestCase
  setup do
    @gallery_submission = gallery_submissions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gallery_submissions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gallery_submission" do
    assert_difference('GallerySubmission.count') do
      post :create, gallery_submission: { additional_description: @gallery_submission.additional_description, collection_id: @gallery_submission.collection_id, gallery_id: @gallery_submission.gallery_id, user_id: @gallery_submission.user_id }
    end

    assert_redirected_to gallery_submission_path(assigns(:gallery_submission))
  end

  test "should show gallery_submission" do
    get :show, id: @gallery_submission
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gallery_submission
    assert_response :success
  end

  test "should update gallery_submission" do
    patch :update, id: @gallery_submission, gallery_submission: { additional_description: @gallery_submission.additional_description, collection_id: @gallery_submission.collection_id, gallery_id: @gallery_submission.gallery_id, user_id: @gallery_submission.user_id }
    assert_redirected_to gallery_submission_path(assigns(:gallery_submission))
  end

  test "should destroy gallery_submission" do
    assert_difference('GallerySubmission.count', -1) do
      delete :destroy, id: @gallery_submission
    end

    assert_redirected_to gallery_submissions_path
  end
end
