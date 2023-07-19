require 'rails_helper'

RSpec.describe "home", type: :system do
  describe 'top画面' do
    let!(:user) { create(:user) }
    let!(:book) { create(:book) }
    let!(:narou) { create(:narou) }
    let!(:latest_reviews) { create_list(:review, 5, user_id: user.id, book_id: book.id) }
    let!(:other_review) { create(:review, user_id: user.id, book_id: book.id, content: "narou6") }
    let!(:latest_narou_reviews) { create_list(:narou_review, 5, user_id: user.id, narou_id: narou.id) }
    let!(:other_narou_review) { create(:narou_review, user_id: user.id, narou_id: narou.id, content: "narou6") }

    before do
      visit root_path
    end

    it 'ページのタイトルが正しく表示されていること' do
      expect(page).to have_title "Okinove"
    end

    context '一般小説の最新投稿' do
      it 'レビューが6つあっても5つのみ表示されていること' do
        within(".latest-reviews") do
          expect(page).to have_selector ".review-item", count: 5
        end
      end

      it '6つ目のレビューが表示されていないこと' do
        within(".latest-reviews") do
          expect(page).to have_no_content other_review.content
        end
      end

      it '小説タイトルをクリックすると該当小説の詳細ページに遷移すること' do
        within(".latest-reviews") do
          click_on latest_reviews[0].book.title, match: :first
          expect(page).to have_current_path book_path(latest_reviews[0].book.id)
        end
      end

      it 'レビュー情報が表示されていること' do
        within(".latest-reviews") do
          expect(page).to have_content latest_reviews[0].content
          expect(page).to have_content latest_reviews[0].created_at.strftime("%Y/%m/%d")
          expect(page).to have_content latest_reviews[0].book.title
          expect(page).to have_content latest_reviews[0].user.name
          expect(page).to have_selector("img[src$='NCG260-2000x1200.jpg']")
        end
      end
    end

    context 'web小説の最新投稿' do
      before do
        click_on "web小説の最新レビュー"
      end

      it 'レビューが6つあっても5つのみ表示されていること' do
        within(".latest-narou-reviews") do
          expect(page).to have_selector ".narou-review-item", count: 5
        end
      end

      it '6つ目のレビューが表示されていないこと' do
        within(".latest-narou-reviews") do
          expect(page).to have_no_content other_narou_review.content
        end
      end

      it '小説タイトルをクリックすると該当小説の詳細ページに遷移すること' do
        within(".latest-narou-reviews") do
          click_on latest_narou_reviews[0].narou.title, match: :first
          expect(page).to have_current_path narou_path(latest_narou_reviews[0].narou.id)
        end
      end

      it 'レビュー情報が表示されていること' do
        within(".latest-narou-reviews") do
          expect(page).to have_content latest_narou_reviews[0].content
          expect(page).to have_content latest_narou_reviews[0].created_at.strftime("%Y/%m/%d")
          expect(page).to have_content latest_narou_reviews[0].narou.title
          expect(page).to have_content latest_narou_reviews[0].user.name
          expect(page).to have_selector("img[src$='NCG260-2000x1200.jpg']")
        end
      end
    end
  end
end
