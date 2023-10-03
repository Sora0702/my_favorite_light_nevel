class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.build(review_params)
    @review.user_id = current_user.id
    @reviews = @book.reviews.order(created_at: :desc)

    @review.save
    render :index
  end

  def destroy
    @book = Book.find(params[:book_id])
    @review = Review.find(params[:id])
    @reviews = @book.reviews.order(created_at: :desc)

    @review.destroy
    render :index
  end

  private

  def review_params
    params.require(:review).permit(:content, :book_id, :user_id)
  end
end
