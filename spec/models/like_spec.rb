require 'rails_helper'

RSpec.describe Like, type: :model do
  let!(:book) { create(:book) }
  let!(:user) { create(:user) }
  let!(:like) { create(:like, user_id: user.id, book_id: book.id) }

  describe 'like' do
    it '有効な属性が登録された場合は、モデルが有効になっていること' do
      expect(like).to be_valid
    end

    it 'user_idが空白の場合に無効となること' do
      other_like = Like.new(user_id: "")
      other_like.valid?
      expect(other_like.errors[:user_id]).to include("を入力してください")
    end

    it 'book_idが空白の場合に無効となること' do
      other_like = Like.new(book_id: "")
      other_like.valid?
      expect(other_like.errors[:book_id]).to include("を入力してください")
    end

    it '同一ユーザーはすでにお気に入り登録しているbookに対してお気に入り登録ができないこと' do
      duplicated_like = Like.new(user_id: user.id, book_id: book.id)
      duplicated_like.valid?
      expect(duplicated_like.errors[:user_id]).to include("はすでに存在します")
    end
  end
end
