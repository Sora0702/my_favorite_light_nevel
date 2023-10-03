require 'rails_helper'

RSpec.describe NarouLike, type: :model do
  let!(:narou) { create(:narou) }
  let!(:user) { create(:user) }
  let!(:narou_like) { create(:narou_like, user_id: user.id, narou_id: narou.id) }

  describe 'narou_like' do
    it '有効な属性が登録された場合は、モデルが有効になっていること' do
      expect(narou_like).to be_valid
    end

    it 'user_idが空白の場合に無効となること' do
      other_narou_like = NarouLike.new(user_id: "")
      other_narou_like.valid?
      expect(other_narou_like.errors[:user_id]).to include("を入力してください")
    end

    it 'book_idが空白の場合に無効となること' do
      other_narou_like = NarouLike.new(narou_id: "")
      other_narou_like.valid?
      expect(other_narou_like.errors[:narou_id]).to include("を入力してください")
    end

    it '同一ユーザーはすでにお気に入り登録しているnarouに対してお気に入り登録ができないこと' do
      duplicated_narou_like = NarouLike.new(user_id: user.id, narou_id: narou.id)
      duplicated_narou_like.valid?
      expect(duplicated_narou_like.errors[:user_id]).to include("はすでに存在します")
    end
  end
end
