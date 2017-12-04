require 'test_helper'

class ReviewControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    @other_user = users(:two)
    @other_user_2 = users(:user_with_avatar)
    @review_one = reviews(:review_one)
    @review_two = reviews(:review_two)
    @rating = 3
    @description = "This guy's okay"
  end
  
  test "can get index of users" do
    get user_reviews_url(@other_user.id)
    assert_response :success
  end

  test "can create review" do
    assert_difference 'Review.count' do
      post user_reviews_url(@other_user_2.id),
        params: {review: {
          reviewer_id: @user.id,
          reviewee_id: @other_user_2.id,
          rating: @rating,
          description: @description}}
    end
    assert_redirected_to user_reviews_url(@other_user_2.id)

    assert_equal @user.id, Review.last.reviewer_id
    assert_equal @other_user_2.id, Review.last.reviewee_id
    assert_equal @rating, Review.last.rating
    assert_equal @description, Review.last.description
  end

  test "can update review" do
    assert @review_one.reviewer_id == @user.id
    assert @review_one.reviewee_id == @other_user.id

    patch user_review_url(@other_user.id, @review_one.id),
      params: { review: {
          rating: @rating,
          description: @description}}

    assert_redirected_to user_reviews_url(@other_user.id)

    assert_equal @rating, @review_one.reload.rating
    assert_equal @description, @review_one.reload.description
  end

  test "can delete review" do
    assert @review_one.reviewer_id == @user.id
    assert @review_one.reviewee_id == @other_user.id
    
    assert_difference('Review.count', -1) do
      delete user_review_url(@other_user.id, @review_one.id)
    end

    assert_redirected_to user_reviews_url(@other_user.id)
  end
end
