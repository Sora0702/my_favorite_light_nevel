require 'rails_helper'

RSpec.describe 'User', type: :model do
  let!(:book) { create(:book) }
  let!(:narou) { create(:narou) }
  let!(:user) { create(:user) }

  before do
    user.image = fixture_file_upload("test_image.jpg")
  end

  describe 'user' do
    it '有効な属性が登録された場合は、モデルが有効になっていること' do
      expect(user).to be_valid
    end

    it 'nameが空白の場合に無効となること' do
      other_user = User.new(name: "")
      other_user.valid?
      expect(other_user.errors[:name]).to include("を入力してください")
    end

    it 'introductionの文字数が300文字を超えた場合に無効となること' do
      other_user = User.new(introduction: "a" * 301)
      other_user.valid?
      expect(other_user.errors[:introduction]).to include("は300文字以内で入力してください")
    end
  end

  describe '#self.guest' do
    it 'ゲストユーザーの情報が正しく登録されること' do
      expect(User.guest.name).to eq("ゲストユーザー")
      expect(User.guest.introduction).to eq("ゲストユーザーでログイン中です。")
      expect(User.guest.email).to eq("guest@example.com")
    end
  end

  describe 'like' do
    it 'ユーザーがbookのお気に入り登録ができること' do
      expect { user.like(book) }.to change(Like, :count).by(1)
    end

    it 'ユーザーがbookのお気に入り解除ができること' do
      user.like(book)
      expect { user.unlike(book) }.to change(Like, :count).by(-1)
    end

    describe '#like?' do
      context 'お気に入り登録している場合' do
        it 'trueとなること' do
          user.like(book)
          expect(user.like?(book)).to be_truthy
        end
      end

      context 'お気に入り登録していない場合' do
        it 'falseとなること' do
          expect(user.like?(book)).to be_falsey
        end
      end
    end
  end

  describe 'narou_like' do
    it 'ユーザーがnarouのお気に入り登録ができること' do
      expect { user.narou_like(narou) }.to change(NarouLike, :count).by(1)
    end

    it 'ユーザーがnarouのお気に入り解除ができること' do
      user.narou_like(narou)
      expect { user.narou_unlike(narou) }.to change(NarouLike, :count).by(-1)
    end

    describe '#narou_like?' do
      context 'お気に入り登録している場合' do
        it 'trueとなること' do
          user.narou_like(narou)
          expect(user.narou_like?(narou)).to be_truthy
        end
      end

      context 'お気に入り登録していない場合' do
        it 'falseとなること' do
          expect(user.narou_like?(narou)).to be_falsey
        end
      end
    end
  end
end
