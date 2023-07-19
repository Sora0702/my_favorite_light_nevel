require 'rails_helper'

RSpec.describe "users", type: :system do
  let!(:user) { create(:user) }

  before do
    login(user)
  end

  describe 'プロフィール詳細ページ' do
    before do
      visit profile_path
    end

    it 'プロフィール詳細ページのタイトルが正しく表示されていること' do
      expect(page).to have_title "プロフィール詳細 - Okinove"
    end

    it 'ユーザー情報が表示されていること' do
      within(".profile-box") do
        expect(page).to have_content user.name
        expect(page).to have_content user.introduction
      end
    end

    describe 'ユーザーアイコン' do
      context 'ユーザーアイコンが登録されていない場合' do
        it 'デフォルトアイコンが表示されること' do
          within(".Profile-image") do
            expect(page).to have_selector("img[src$='NCG260-2000x1200.jpg']")
          end
        end
      end

      context 'ユーザーアイコンが登録されている場合' do
        it '登録したアイコンが表示されること' do
          user_image
          visit profile_path
          within(".Profile-image") do
            expect(page).to have_selector("img[src$='test_image.jpg']")
          end
        end
      end
    end

    describe 'ユーザーおよびアカウント情報の編集リンクについて' do
      it 'プロフィールを編集ボタンを押下した際に、プロフィール編集画面に遷移すること' do
        within('.Edit-information') do
          click_on 'プロフィールを編集'
          expect(page).to have_current_path profile_edit_path
        end
      end

      it 'アカウント情報を編集ボタンを押下した際に、アカウント編集画面に遷移すること' do
        within('.Edit-information') do
          click_on 'アカウント情報を編集'
          expect(page).to have_current_path edit_user_registration_path
        end
      end
    end
  end

  describe 'プロフィール編集ページ' do
    before do
      visit profile_edit_path
    end

    it 'プロフィール編集ページのタイトルが正しく表示されていること' do
      expect(page).to have_title "プロフィール編集 - Okinove"
    end

    describe 'プロフィール編集機能' do
      context 'ユーザー名が入力されている場合' do
        before do
          fill_in 'user-name', with: "testuser"
          fill_in 'user-introduction', with: "test"
          attach_file "#{Rails.root}/spec/fixtures/files/test_image.jpg"
          click_on '更新する'
        end

        it '正常に編集されること' do
          within('.flash-message') do
            expect(page).to have_content "プロフィールの編集が完了しました"
          end
        end

        it '編集後の情報が表示されること' do
          within(".profile-box") do
            expect(page).to have_content "testuser"
            expect(page).to have_content "test"
            expect(page).to have_selector("img[src$='test_image.jpg']")
          end
        end
      end

      context 'ユーザー名が入力されていない場合' do
        before do
          fill_in 'user-name', with: ""
          click_on '更新する'
        end

        it 'エラーとなる' do
          within('.flash-message') do
            expect(page).to have_content "プロフィールの編集に失敗しました"
          end
        end
      end

      it 'キャンセルボタンを押下した際に、プロフィール画面に遷移すること' do
        click_on 'キャンセル'
        expect(page).to have_current_path profile_path
      end
    end
  end
end
