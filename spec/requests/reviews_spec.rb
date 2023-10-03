require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let!(:user) { create(:user) }
  let!(:book) { create(:book) }
  let!(:review) { create(:review, user_id: user.id, book_id: book.id) }
  let(:review_params) { { review: { content: "test" } } }

  before do
    sign_in user
    get book_path(book)
  end

  describe 'POST reviews' do
    it "リクエストが成功したらレビューが１件保存されていること" do
      expect do
        post book_reviews_path(book), xhr: true, params: review_params
      end.to change(Review, :count).by(1)
    end

    it "リクエストが成功すること" do
      post book_reviews_path(book), xhr: true, params: review_params
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE reviews' do
    it "リクエストが成功したらレビューが１件削除されていること" do
      expect do
        delete book_review_path(book), xhr: true
      end.to change(Review, :count).by(-1)
    end

    it "リクエストが成功すること" do
      delete book_review_path(book), xhr: true
      expect(response).to have_http_status(200)
    end
  end
end
