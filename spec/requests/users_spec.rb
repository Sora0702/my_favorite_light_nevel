require 'rails_helper'

RSpec.describe 'user', type: :request do
  let(:user) { create(:user) }
  before do
    sign_in user
    user.image = fixture_file_upload("test_image.jpg")
  end

  describe 'GET #profile' do
    before do
      get profile_path
    end

    it 'プロフィール詳細ページへ正常にアクセスできること' do
      expect(response).to have_http_status(200)
    end

    it 'ユーザー名を正常に取得できること' do
      expect(response.body).to include(user.name)
    end

    it '自己紹介文が正しく取得できること' do
      expect(response.body).to include(user.introduction)
    end

    it 'ユーザーアイコンが正しく取得できること' do
      expect(response.body).to include("test_image.jpg")
    end
  end

  describe 'GET #edit' do
    before do
      get profile_edit_path
    end

    it 'プロフィール編集ページへ正常にアクセスできること' do
      expect(response).to have_http_status(200)
    end

    it 'ログインユーザーのユーザー名と自己紹介文が取得できること' do
      expect(response.body).to include(user.name, user.introduction)
    end
  end
end
