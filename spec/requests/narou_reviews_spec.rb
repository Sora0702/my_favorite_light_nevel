require 'rails_helper'

RSpec.describe "NarouReviews", type: :request do
  let!(:user) { create(:user) }
  let!(:narou) { create(:narou) }
  let!(:narou_review) { create(:narou_review, user_id: user.id, narou_id: narou.id) }
  let(:narou_review_params) { { narou_review: { content: "test" } } }

  before do
    sign_in user
    get narou_path(narou)
  end

  describe 'POST narou_reviews' do
    it "リクエストが成功したらレビューが１件保存されていること" do
      expect do
        post narou_narou_reviews_path(narou), xhr: true, params: narou_review_params
      end.to change(NarouReview, :count).by(1)
    end

    it "リクエストが成功すること" do
      post narou_narou_reviews_path(narou), xhr: true, params: narou_review_params
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE narou_reviews' do
    it "リクエストが成功したらレビューが１件削除されていること" do
      expect do
        delete narou_narou_review_path(narou), xhr: true
      end.to change(NarouReview, :count).by(-1)
    end

    it "リクエストが成功すること" do
      delete narou_narou_review_path(narou), xhr: true
      expect(response).to have_http_status(200)
    end
  end
end
