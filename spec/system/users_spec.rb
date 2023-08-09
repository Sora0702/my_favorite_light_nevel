require 'rails_helper'

RSpec.describe "users", type: :system do
  let!(:user) { create(:user) }
  let!(:book) { create(:book) }
  let!(:other_book) { create(:book, title: "二番目の", isbn: 1, author: "other_author", image_url: "https://1.bp.blogspot.com/-rzRcgoXDqEg/YAOTCKoCpPI/AAAAAAABdOI/5Bl3_zhOxm07TUGzW8_83cXMOT9yy1VJwCNcBGAsYHQ/s1041/onepiece02_zoro_bandana.png") }
  let!(:like) { create(:like, user_id: 1, book_id: 1) }
  let!(:narou) { create(:narou) }
  let!(:other_narou) { create(:narou, title: "二番目の", ncode: "2", writer: "other_author") }
  let!(:narou_like) { create(:narou_like, user_id: 1, narou_id: 1) }

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

    context '一般小説のお気に入り一覧' do
      it 'お気に入り登録した小説の情報が表示されていること' do
        within(".book-box") do
          expect(page).to have_content book.title
          expect(page).to have_content book.author
          expect(page).to have_selector("img[src$='#{book.image_url}']")
          expect(page).to have_content "お気に入り登録を解除する"
        end
      end

      it 'お気に入り登録していない小説が表示されていないこと' do
        within(".book-box") do
          expect(page).not_to have_content other_book.title
          expect(page).not_to have_content other_book.author
          expect(page).not_to have_selector("img[src$='#{other_book.image_url}']")
        end
      end

      it 'レビューするボタンを押下した際に、小説の詳細ページに遷移すること' do
        within(".book-box") do
          find(".link-to-review").click
          expect(page).to have_current_path book_path(book)
        end
      end

      it 'お気に入り解除ができること' do
        find("#like-btn").click
        sleep 0.5
        expect(user.likes.count).to eq(0)
      end
    end

    context 'web小説のお気に入り一覧' do
      before do
        click_on "web小説のお気に入り一覧"
      end

      it 'お気に入り登録したweb小説の情報が表示されていること' do
        within(".narou-box") do
          expect(page).to have_content narou.title
          expect(page).to have_content narou.writer
          expect(page).to have_content "お気に入り登録を解除する"
        end
      end

      it 'お気に入り登録していないweb小説が表示されていないこと' do
        within(".narou-box") do
          expect(page).not_to have_content other_narou.title
          expect(page).not_to have_content other_narou.writer
        end
      end

      it 'レビューするボタンを押下した際に、web小説の詳細ページに遷移すること' do
        within(".narou-box") do
          find(".link-to-review").click
          expect(page).to have_current_path narou_path(narou)
        end
      end

      it 'お気に入り解除ができること' do
        find("#like-btn").click
        sleep 0.5
        expect(user.narou_likes.count).to eq(0)
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
