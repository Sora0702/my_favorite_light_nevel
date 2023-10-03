require 'rails_helper'

RSpec.describe Review, type: :model do
  let!(:user) { create(:user) }
  let!(:book) { create(:book)}
  let(:review) { create(:review, user_id: user.id, book_id: book.id) }

  describe 'review' do
    it '有効な属性が登録された場合は、モデルが有効になっていること' do
      expect(review).to be_valid
    end

    it 'contentが空白の場合に無効となること' do
      review = Review.new(content: nil)
      review.valid?
      expect(review.errors[:content]).to include("を入力してください")
    end

    it 'contentの文字数が300文字を超えた場合に無効となること' do
      review = Review.new(content: "a" * 401)
      review.valid?
      expect(review.errors[:content]).to include("は400文字以内で入力してください")
    end
  end
end
