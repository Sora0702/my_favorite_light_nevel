require 'rails_helper'

RSpec.describe "narous", type: :system do
  let!(:narou) { create(:narou) }
  let!(:other_narou) { create(:narou, title: "二番目の", ncode: "2", writer: "other_author") }
  let!(:user) { create(:user) }
  let(:user_narou_review) { build(:narou_review, user_id: user.id, narou_id: narou.id, content: "user-content", id: 2) }
  let!(:other_user) { create(:user, name: "test-user", email: "test2@test.com", password: "password2") }
  let!(:other_user_narou_review) { create(:narou_review, user_id: other_user.id, narou_id: narou.id) }

  describe '登録済み小説一覧画面' do
    before do
      visit narous_path
    end

    it 'ページのタイトルが正しく表示されていること' do
      expect(page).to have_title "登録済みweb小説一覧 - Novel Share"
    end

    context '検索した場合' do
      before do
        fill_in 'keyword', with: "title"
        click_on '検索'
      end

      it 'keywordと部分一致した小説情報が表示されていること' do
        within(".narou-box") do
          expect(page).to have_content narou.title
          expect(page).to have_content narou.writer
        end
      end

      it 'keywordを含まない小説情報が表示されないこと' do
        within(".narou-box") do
          expect(page).not_to have_content other_narou.title
          expect(page).not_to have_content other_narou.writer
        end
      end
    end

    context '検索しない場合' do
      it '登録済みの小説が全て表示されていること' do
        expect(page).to have_selector ".narou-box", count: 2
      end
    end
  end

  describe '小説詳細画面' do
    before do
      visit narou_path(narou)
    end

    it 'ページのタイトルが正しく表示されていること' do
      expect(page).to have_title "#{narou.title} - Novel Share"
    end

    it '小説名が表示されていること' do
      expect(page).to have_selector ".narou-title", text: narou.title
    end

    it '小説情報が表示されていること' do
      within(".narou-box") do
        expect(page).to have_content narou.writer
        expect(page).to have_content narou.story
      end
    end

    it '小説の購入はこちらをクリックした際に該当の商品ページへ遷移すること' do
      within(".narou-box") do
        click_on "この小説を読む"
        expect(page).to have_current_path "https://ncode.syosetu.com/#{narou.ncode}/"
      end
    end

    describe 'レビューの表示について' do
      context 'ログインしている場合' do
        before do
          login(user)
          user_image
          visit narou_path(narou)
          fill_in 'review-content', with: user_narou_review.content
          click_on '投稿する'
        end

        describe 'レビュー投稿' do
          it 'レビュー投稿のフォームが表示されていること' do
            expect(page).to have_selector ".review-form"
          end

          it 'レビューの投稿後、ページに投稿および投稿情報が表示されること' do
            within("#reviews-area") do
              expect(page).to have_selector("img[src$='test_image.jpg']")
              expect(page).to have_selector ".review-user-name", text: user_narou_review.user.name
              expect(page).to have_selector ".review-content", text: user_narou_review.content
              expect(page).to have_selector ".review-other-informaiton", text: user_narou_review.created_at.strftime("%Y/%m/%d")
            end
          end
        end

        describe 'レビュー削除' do
          it '投稿削除機能が表示されていること' do
            expect(page).to have_selector ".review-delete-#{user_narou_review.id}"
          end

          it 'ゴミ箱マークをクリックした際に投稿削除ができること' do
            accept_alert do
              find(".review-delete-#{user_narou_review.id}").click
            end
            within("#reviews-area") do
              expect(page).not_to have_content user_narou_review.content
            end
          end

          it 'レビュー作成ユーザーとログインユーザーが異なる場合に削除機能が表示されないこと' do
            expect(page).not_to have_selector ".review-delete-#{other_user_narou_review.id}"
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
            expect(page).to have_selector ".review-user-name", text: other_user_narou_review.user.name
            expect(page).to have_selector ".review-content", text: other_user_narou_review.content
            expect(page).to have_selector ".review-other-informaiton",
text: other_user_narou_review.created_at.strftime("%Y/%m/%d")
          end
        end

        it '投稿削除が表示されていないこと' do
          expect(page).not_to have_selector ".review-delete"
        end
      end
    end
  end

  describe '小説検索画面' do
    before do
      visit narous_search_path
    end

    it 'ページのタイトルが正しく表示されていること' do
      expect(page).to have_title "web小説を検索する - Novel Share"
    end

    context '検索し、小説が見つかった場合' do
      before do
        fill_in 'keyword', with: "教室"
        click_on '検索'
      end

      it '検索結果が表示されること' do
        within(".result-box") do
          expect(page).to have_content "教室"
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
