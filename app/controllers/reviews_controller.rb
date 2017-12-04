class ReviewsController < ApplicationController
  def index
    @reviews = find_reviews_with_reviewee_id
  end


  def create
    @review = Review.new(create_review_params)
    review_verification(@review)

    if(@review.save)
      calculate_rating(@review.reviewee)
      redirect_to user_reviews_path(reviewee_id), notice: "Successfully submitted review!"
    else
      render 'new'
    end
  end

  def new
    @review = Review.new
    @rating_options = [1,2,3,4,5];
  end

  def edit
    @review = find_review_with_id
    review_verification(@review)
  end

  def update
    @review = find_review_with_id
    if(@review.update(update_review_params))
      calculate_rating(@review.reviewee)
      redirect_to user_reviews_path(reviewee_id), notice: "Successfully editted review!"
    else
      render 'edit'
    end
  end

  def destroy
    @review = find_review_with_id
    review_verification(@review)
    @reviewee = @review.reviewee
    @review.destroy
    calculate_rating(@reviewee)

    redirect_to user_reviews_path(reviewee_id), notice: "Successfully deleted review!"
  end

  private
    def create_review_params
      params.require(:review).permit(:reviewer_id, :reviewee_id, :rating, :description)
    end

    def update_review_params
      params.require(:review).permit(:rating, :description)
    end

    def find_review_with_id
      # really confusing, but params[:id] contains the username.
      Review.where(id: params[:id]).first
    end

    def find_reviews_with_reviewee_id
      Review.where(reviewee_id: reviewee_id)
    end

    def review_verification(review)
      if(review.nil?)
        redirect_to user_reviews_path(reviewee_id), notice: "Requested review doesn't exist"
      elsif(review.reviewer_id != current_user.id)
        redirect_to user_reviews_path(reviewee_id), notice: "Requested review isn't written by you"
      elsif (review.reviewee_id != reviewee_id)
        redirect_to user_reviews_path(reviewee_id), notice: "Requested review isn't for this user"
      end
    end

    def reviewee_id
      params[:user_id].to_i
    end

    def calculate_rating(user)
      @updated_rating = user.received_reviews.average(:rating)
      if @updated_rating.nil?
        @updated_rating = 0
      end
      user.update(rating: @updated_rating)
    end
end
