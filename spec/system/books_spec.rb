require 'rails_helper'

RSpec.describe "books", type: :system do
  let!(:book) { create(:book) }
  let!(:other_book) { create(:book, title: "二番目の", isbn: 1, author: "other_author", image_url: "https://1.bp.blogspot.com/-rzRcgoXDqEg/YAOTCKoCpPI/AAAAAAABdOI/5Bl3_zhOxm07TUGzW8_83cXMOT9yy1VJwCNcBGAsYHQ/s1041/onepiece02_zoro_bandana.png") }
  let!(:user) { create(:user) }
  let(:user_review) { build(:review, user_id: user.id, book_id: book.id, content: "user-content", id: 2) }
  let!(:other_user) { create(:user, name: "test-user", email: "test2@test.com", password: "password2") }
  let!(:other_user_review) { create(:review, user_id: other_user.id, book_id: book.id) }

  describe '登録済み小説一覧画面' do
    before do
      visit books_path
    end

    it 'ページのタイトルが正しく表示されていること' do
      expect(page).to have_title "登録済み小説一覧 - Novel Share"
    end

    context '検索した場合' do
      before do
        fill_in 'keyword', with: "title"
        click_on '検索'
      end

      it 'keywordと部分一致した小説情報が表示されていること' do
        within(".book-box") do
          expect(page).to have_content book.title
          expect(page).to have_content book.author
          expect(page).to have_selector("img[src$='#{book.image_url}']")
        end
      end

      it 'keywordを含まない小説情報が表示されないこと' do
        within(".book-box") do
          expect(page).not_to have_content other_book.title
          expect(page).not_to have_content other_book.author
          expect(page).not_to have_selector("img[src$='#{other_book.image_url}']")
        end
      end
    end

    context '検索しない場合' do
      it '登録済みの小説が全て表示されていること' do
        expect(page).to have_selector ".book-box", count: 2
      end
    end
  end

  describe '小説詳細画面' do
    before do
      visit book_path(book)
    end

    it 'ページのタイトルが正しく表示されていること' do
      expect(page).to have_title "#{book.title} - Novel Share"
    end

    it '小説名が表示されていること' do
      expect(page).to have_selector ".book-title", text: book.title
    end

    it '小説情報が表示されていること' do
      within(".book-box") do
        expect(page).to have_content book.author
        expect(page).to have_selector("img[src$='#{book.image_url}']")
      end
    end

    it '小説の購入はこちらをクリックした際に該当の商品ページへ遷移すること' do
      within(".book-box") do
        click_on "小説の購入はこちら"
        expect(page).to have_current_path book.url
      end
    end

    describe 'レビューの表示について' do
      context 'ログインしている場合' do
        before do
          login(user)
          user_image
          visit book_path(book)
          fill_in 'review-content', with: user_review.content
          click_on '投稿する'
        end

        describe 'レビュー投稿' do
          it 'レビュー投稿のフォームが表示されていること' do
            expect(page).to have_selector ".review-form"
          end

          it 'レビューの投稿後、ページに投稿および投稿情報が表示されること' do
            within("#reviews-area") do
              expect(page).to have_selector("img[src$='test_image.jpg']")
              expect(page).to have_selector ".review-user-name", text: user_review.user.name
              expect(page).to have_selector ".review-content", text: user_review.content
              expect(page).to have_selector ".review-other-informaiton", text: user_review.created_at.strftime("%Y/%m/%d")
            end
          end
        end

        describe 'レビュー削除' do
          it '投稿削除機能が表示されていること' do
            expect(page).to have_selector ".review-delete-#{user_review.id}"
          end

          it 'ゴミ箱マークをクリックした際に投稿削除ができること' do
            accept_alert do
              find(".review-delete-#{user_review.id}").click
            end
            within("#reviews-area") do
              expect(page).not_to have_content user_review.content
            end
          end

          it 'レビュー作成ユーザーとログインユーザーが異なる場合に削除機能が表示されないこと' do
            expect(page).not_to have_selector ".review-delete-#{other_user_review.id}"
          end
        end
      end

      context 'ログインしていない場合' do
        it 'レビュー投稿のフォームが表示されていないこと' do
          expect(page).not_to have_selector ".review-form"
        end

        it '登録済みの投稿および投稿情報が表示されること' do
          within("#reviews-area") do
            expect(page).to have_selector("img[src$='NCG260-2000x1200.jpg']")
            expect(page).to have_selector ".review-user-name", text: other_user_review.user.name
            expect(page).to have_selector ".review-content", text: "MyText"
            expect(page).to have_selector ".review-other-informaiton", text: other_user_review.created_at.strftime("%Y/%m/%d")
          end
        end

        it '投稿削除が表示されていないこと' do
          expect(page).not_to have_selector ".review-delete"
        end
      end
    end

    describe 'お気に入り登録について' do
      context 'ログインしている場合' do
        before do
          login(user)
          visit book_path(book)
        end

        it 'お気に入り機能が表示されること' do
          expect(page).to have_selector ".like-box"
        end

        context 'お気に入り登録している場合' do
          before do
            find("#like-btn").click
          end

          it 'お気に入り解除項目が表示されていること' do
            expect(page).to have_content "お気に入り登録を解除する"
          end

          it 'お気に入り解除ができること' do
            find("#like-btn").click
            sleep 0.5
            expect(user.likes.count).to eq(0)
          end
        end

        context 'お気に入り登録していない場合' do
          it 'お気に入り登録項目が表示されていること' do
            expect(page).to have_content "お気に入り登録する"
          end

          it 'お気に入り登録ができること' do
            find("#like-btn").click
            sleep 0.5
            expect(user.likes.count).to eq(1)
          end
        end
      end

      context 'ログインしていない場合' do
        it 'お気に入り機能が表示されないこと' do
          expect(page).not_to have_selector ".like-box"
        end
      end
    end
  end

  describe '小説検索画面' do
    before do
      visit books_search_path
    end

    it 'ページのタイトルが正しく表示されていること' do
      expect(page).to have_title "小説を検索する - Novel Share"
    end

    context '検索した場合' do
      before do
        fill_in 'keyword', with: "教室"
        click_on '検索'
      end

      it '検索結果が表示されること' do
        within(".result-box") do
          expect(page).to have_content "教室"
        end
      end

      describe '小説の登録' do
        context '未登録小説の場合' do
          it '検索結果から小説を登録するボタンを押下した際に登録ができること' do
            expect { click_on "小説を登録する", match: :first }.to change(Book, :count).by(1)
          end

          it '登録成功後に小説の詳細ページに遷移すること' do
            click_on "小説を登録する", match: :first
            expect(page).to have_current_path book_path(Book.third.id)
          end
        end

        context '登録済み小説の場合' do
          before do
            click_on "小説を登録する", match: :first
            visit books_search_path
            fill_in 'keyword', with: "教室"
            click_on '検索'
          end

          it '検索結果から小説を登録するボタンを押下した際に登録されないこと' do
            expect { click_on "小説を登録する", match: :first }.to change(Book, :count).by(0)
          end

          it '小説の詳細ページに遷移すること' do
            click_on "小説を登録する", match: :first
            expect(page).to have_current_path book_path(Book.third.id)
          end
        end
      end
    end

    context '検索しない場合、小説が見つからない場合' do
      it '検索結果が存在しないこと' do
        expect(page).not_to have_selector(".result-box")
      end

      it 'フラッシュメッセージが表示されること' do
        within(".flash-message") do
          expect(page).to have_content("小説のタイトルを入力してください。")
        end
      end
    end
  end
end
