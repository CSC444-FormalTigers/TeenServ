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

  test "rating updates on creation" do
    assert_difference 'Review.count' do
      post user_reviews_url(@other_user_2.id),
        params: {review: {
          reviewer_id: @user.id,
          reviewee_id: @other_user_2.id,
          rating: @rating,
          description: @description}}
    end
    assert_redirected_to user_reviews_url(@other_user_2.id)

    assert(@rating == @other_user_2.reload.rating)
  end

  test "rating updates on edit" do
    assert @review_one.reviewer_id == @user.id
    assert @review_one.reviewee_id == @other_user.id

    patch user_review_url(@other_user.id, @review_one.id),
      params: { review: {
          rating: @rating,
          description: @description}}

    assert_redirected_to user_reviews_url(@other_user.id)

    assert(@rating == @other_user.reload.rating)
  end

  test "rating updates on delete" do
    assert @review_one.reviewer_id == @user.id
    assert @review_one.reviewee_id == @other_user.id
    
    assert_difference('Review.count', -1) do
      delete user_review_url(@other_user.id, @review_one.id)
    end

    assert_redirected_to user_reviews_url(@other_user.id)

    assert(0 == @other_user.reload.rating)
  end

  test "rating update with multiple reviews" do
    @old_rating = @review_one.rating

    sign_out @user
    sign_in @other_user_2

    assert_difference 'Review.count' do
      post user_reviews_url(@other_user.id),
        params: {review: {
          reviewer_id: @other_user_2.id,
          reviewee_id: @other_user.id,
          rating: @rating,
          description: @description}}
    end

    assert_redirected_to user_reviews_url(@other_user.id)

    @new_rating = (@old_rating + @rating)/2.0

    assert(@new_rating == @other_user.reload.rating)

    sign_out @other_user_2
    sign_in @user
  end

  test "cannot create review as someone else" do
    assert_no_difference 'Review.count' do
      post user_reviews_url(@other_user_2.id),
        params: {review: {
          reviewer_id: @other_user.id,
          reviewee_id: @other_user_2.id,
          rating: @rating,
          description: @description}}
    end
    assert_redirected_to user_reviews_url(@other_user_2.id)
  end

  test "cannot create review through wrong user path" do
    assert_no_difference 'Review.count' do
      post user_reviews_url(@other_user.id),
        params: {review: {
          reviewer_id: @user.id,
          reviewee_id: @other_user_2.id,
          rating: @rating,
          description: @description}}
    end
    assert_redirected_to user_reviews_url(@other_user.id)
  end

  test "cannot update review that user did not write" do
    sign_out @user
    sign_in @other_user_2

    assert @review_one.reviewer_id == @user.id
    assert @review_one.reviewee_id == @other_user.id

    patch user_review_url(@other_user.id, @review_one.id),
      params: { review: {
          rating: @rating,
          description: @description}}

    assert_redirected_to user_reviews_url(@other_user.id)

    assert_not_equal @rating, @review_one.reload.rating
    assert_not_equal @description, @review_one.reload.description

    sign_out @other_user_2
    sign_in @user
  end

  test "cannot update review through wrong user path" do
    assert @review_one.reviewer_id == @user.id
    assert @review_one.reviewee_id == @other_user.id

    patch user_review_url(@other_user_2.id, @review_one.id),
      params: { review: {
          rating: @rating,
          description: @description}}

    assert_redirected_to user_reviews_url(@other_user_2.id)

    assert_not_equal @rating, @review_one.reload.rating
    assert_not_equal @description, @review_one.reload.description
  end

  test "cannot delete review another user wrote" do
    sign_out @user
    sign_in @other_user_2

    assert @review_one.reviewer_id == @user.id
    assert @review_one.reviewee_id == @other_user.id
    
    assert_no_difference 'Review.count' do
      delete user_review_url(@other_user.id, @review_one.id)
    end

    assert_redirected_to user_reviews_url(@other_user.id)

    sign_out @other_user_2
    sign_in @user
  end

  test "cannot delete review through wrong user path" do
    assert @review_one.reviewer_id == @user.id
    assert @review_one.reviewee_id == @other_user.id
    
    assert_no_difference 'Review.count' do
      delete user_review_url(@other_user_2.id, @review_one.id)
    end

    assert_redirected_to user_reviews_url(@other_user_2.id)
  end

end
