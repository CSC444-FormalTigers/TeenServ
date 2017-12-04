require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "cannot save empty review" do
    review = Review.new
    assert_not review.save, "Can save an empty review"
  end

  test "cannot save review without reviewer" do
    review = Review.new
    review.reviewee_id = users(:one).id
    review.rating = 1
    assert_not review.save, "Can save a review without a reviewer"
  end

  test "cannot save review without reviewee" do
    review = Review.new
    review.reviewer_id = users(:one).id
    review.rating = 1
    assert_not review.save, "Can save a review without a reviewee"
  end

  test "cannot save review without rating" do
    review = Review.new
    review.reviewer_id = users(:one).id
    review.reviewee_id = users(:user_with_avatar).id
    assert_not review.save, "Can save a review without a rating"
  end

  test "cannot save review with user reviewing themself" do
    review = Review.new
    review.reviewer_id = users(:one).id
    review.reviewee_id = users(:one).id
    review.rating = 1
    assert_not review.save, "Can save a review with user reviewing themself"
  end

  test "cannot save review with rating below 1" do
    review = Review.new
    review.reviewer_id = users(:one).id
    review.reviewee_id = users(:user_with_avatar).id
    review.rating = 0
    assert_not review.save, "Can save a review with rating below 1"
  end

  test "cannot save review with rating above 5" do
    review = Review.new
    review.reviewer_id = users(:one).id
    review.reviewee_id = users(:user_with_avatar).id
    review.rating = 6
    assert_not review.save, "Can save a review with rating above 5"
  end

  test "cannot save review with a floating point rating" do
    review = Review.new
    review.reviewer_id = users(:one).id
    review.reviewee_id = users(:user_with_avatar).id
    review.rating = 3.45
    assert_not review.save, "Can save a review with a floating point rating"
  end

  test "can save review without description" do
    review = Review.new
    review.reviewer_id = users(:one).id
    review.reviewee_id = users(:user_with_avatar).id
    review.rating = 4
    assert review.save, "Cannot save a review without description"
  end

  test "can save review with description" do
    review = Review.new
    review.reviewer_id = users(:one).id
    review.reviewee_id = users(:user_with_avatar).id
    review.rating = 4
    review.description = "Describing this user to user interaction"
    assert review.save, "Cannot save a review with description"
  end

  test "cannot review same user more than once" do
    review_one = Review.new
    review_one.reviewer_id = users(:one).id
    review_one.reviewee_id = users(:user_with_avatar).id
    review_one.rating = 4
    review_one.description = "Great experience"
    assert review_one.save, "Cannot save the initial review"

    review_two = Review.new
    review_two.reviewer_id = users(:one).id
    review_two.reviewee_id = users(:user_with_avatar).id
    review_two.rating = 1
    review_two.description = "lol nvm jk this guy sucks"
    assert_not review_two.save, "Can save multiple reviews to the same user"
  end

  test "can receive reviews from different users" do
    review_one = Review.new
    review_one.reviewer_id = users(:one).id
    review_one.reviewee_id = users(:user_with_avatar).id
    review_one.rating = 4
    review_one.description = "Great experience"
    assert review_one.save, "Cannot save review from user one"

    review_two = Review.new
    review_two.reviewer_id = users(:user_with_disposable_avatar).id
    review_two.reviewee_id = users(:user_with_avatar).id
    review_two.rating = 1
    review_two.description = "this guy sucks"
    assert review_two.save, "Cannot save review from user_with_disposable_avatar"
  end

  test "can send reviews to different users" do
    review_one = Review.new
    review_one.reviewer_id = users(:one).id
    review_one.reviewee_id = users(:user_with_avatar).id
    review_one.rating = 4
    review_one.description = "Great experience"
    assert review_one.save, "Cannot save review to user two"

    review_two = Review.new
    review_two.reviewer_id = users(:one).id
    review_two.reviewee_id = users(:user_with_disposable_avatar).id
    review_two.rating = 1
    review_two.description = "this guy sucks"
    assert review_two.save, "Cannot save review to user_with_disposable_avatar"
  end

  test "Get sent review from user" do
    review_one = Review.new
    review_one.reviewer_id = users(:one).id
    review_one.reviewee_id = users(:user_with_avatar).id
    review_one.rating = 4
    review_one.description = "Great experience"
    assert review_one.save, "Cannot save initial review one"

    review_value = users(:one).sent_reviews.find_by(reviewee_id: users(:user_with_avatar).id)
    
    assert review_one.id == review_value.id, "Cannot get sent review from user"
  end

  test "Get received review from user" do
    review_one = Review.new
    review_one.reviewer_id = users(:one).id
    review_one.reviewee_id = users(:user_with_avatar).id
    review_one.rating = 4
    review_one.description = "Great experience"
    assert review_one.save, "Cannot save initial review one"

    review_value = users(:user_with_avatar).received_reviews.find_by(:reviewer_id == users(:one).id)
    
    assert review_one.id == review_value.id, "Cannot get received review from user"
  end

  test "Deleting a user deletes their sent and received reviews" do
    user = users(:one)

    review_one = Review.new
    review_one.reviewer_id = user.id
    review_one.reviewee_id = users(:user_with_avatar).id
    review_one.rating = 4
    review_one.description = "Great experience"
    assert review_one.save, "Cannot save initial review one"

    review_two = Review.new
    review_two.reviewer_id = users(:user_with_avatar).id
    review_two.reviewee_id = user.id
    review_two.rating = 1
    review_two.description = "this guy sucks"
    assert review_two.save, "Cannot save initial review two"

    assert user.destroy
    assert_raise(ActiveRecord::RecordNotFound) { review_one.reload }
    assert_raise(ActiveRecord::RecordNotFound) { review_two.reload }
  end

end
