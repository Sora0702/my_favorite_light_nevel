require 'rails_helper'

RSpec.describe NarouReview, type: :model do
  let!(:user) { create(:user) }
  let!(:narou) { create(:narou) }
  let(:narou_review) { create(:narou_review, user_id: user.id, narou_id: narou.id) }

  describe 'narou_review' do
    it '有効な属性が登録された場合は、モデルが有効になっていること' do
      expect(narou_review).to be_valid
    end

    it 'contentが空白の場合に無効となること' do
      narou_review = NarouReview.new(content: "")
      narou_review.valid?
      expect(narou_review.errors[:content]).to include("を入力してください")
    end

    it 'contentの文字数が400文字を超えた場合に無効となること' do
      narou_review = NarouReview.new(content: "a" * 401)
      narou_review.valid?
      expect(narou_review.errors[:content]).to include("は400文字以内で入力してください")
    end
  end
end
