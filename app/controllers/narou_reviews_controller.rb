class NarouReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @narou = Narou.find(params[:narou_id])
    @narou_review = @narou.narou_reviews.build(narou_review_params)
    @narou_review.user_id = current_user.id
    @narou_reviews = @narou.narou_reviews.order(created_at: :desc)

    @narou_review.save
    render :index
  end

  def destroy
    @narou = Narou.find(params[:narou_id])
    @narou_review = NarouReview.find(params[:id])
    @narou_reviews = @narou.narou_reviews.order(created_at: :desc)

    @narou_review.destroy
    render :index
  end

  private

  def narou_review_params
    params.require(:narou_review).permit(:content, :narou_id, :user_id)
  end
end
