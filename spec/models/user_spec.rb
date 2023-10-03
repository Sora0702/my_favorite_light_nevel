require 'rails_helper'

RSpec.describe 'User', type: :model do
  let(:user) { create(:user) }
  before do
    user.image = fixture_file_upload("test_image.jpg")
  end

  describe 'user' do
    it '有効な属性が登録された場合は、モデルが有効になっていること' do
      expect(user).to be_valid
    end

    it 'nameが空白の場合に無効となること' do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it 'introductionの文字数が300文字を超えた場合に無効となること' do
      user = User.new(introduction: "a" * 301)
      user.valid?
      expect(user.errors[:introduction]).to include("は300文字以内で入力してください")
    end
  end

  describe '#self.guest' do
    it 'ゲストユーザーの情報が正しく登録されること' do
      expect(User.guest.name).to eq("ゲストユーザー")
      expect(User.guest.introduction).to eq("ゲストユーザーでログイン中です。")
      expect(User.guest.email).to eq("guest@example.com")
    end
  end
end
