require 'rails_helper'

RSpec.describe 'Books', type: :request do
  let!(:book) { create(:book) }

  describe 'GET /index' do
    let!(:other_book) { create(:book, title: "二番目の", isbn: 1) }
    let(:book_search_params) { { keyword: "二番目の" } }

    context '検索した場合' do
      before do
        get books_path, params: book_search_params
      end

      it '一覧画面に正常にアクセスできること' do
        expect(response).to have_http_status(200)
      end

      it 'keywordを含む小説の情報が正しく取得できること' do
        expect(response.body).to include("二番目の")
      end

      it 'keywordを含まない小説が取得されないこと' do
        expect(response.body).not_to include("test_title")
      end
    end

    context '検索しない場合' do
      before do
        get books_path
      end

      it '一覧画面に正常にアクセスできること' do
        expect(response).to have_http_status(200)
      end

      it '登録済みの小説の情報が全て正しく取得できること' do
        expect(response.body).to include("二番目の")
        expect(response.body).to include("test_title")
      end
    end
  end

  describe 'GET /search' do
    let(:book_search_params) { { keyword: "教室" } }

    context "検索に成功した場合" do
      before do
        get books_search_path, params: book_search_params
      end

      it "リクエストに成功すること" do
        expect(response).to have_http_status(200)
      end

      it '検索結果が返ってくること' do
        expect(response.body).to include("教室")
      end
    end

    context "検索に失敗した場合" do
      it "パラメータが空文字列の時, フラッシュメッセージが表示されること" do
        get books_search_path, params: { keyword: "" }
        expect(response).to have_http_status(200)
        expect(response.body).to include("小説のタイトルを入力してください。")
      end

      it "パラメータがnilの時, フラッシュメッセージが表示されること" do
        get books_search_path, params: { keyword: nil }
        expect(response).to have_http_status(200)
        expect(response.body).to include("小説のタイトルを入力してください。")
      end
    end
  end

  describe 'POST books' do
    let(:books_params) { { book: { title: "test", suthor: "author", isbn: 12345, url: "test", image_url: "test" } } }
    let(:bad_books_params) { { book: { title: "test", suthor: "author", isbn: 1234, url: "test", image_url: "test" } } }

    it 'リクエストが成功したらshowアクションにリダイレクトすること' do
      post books_create_path, params: books_params
      expect(response).to redirect_to book_path(Book.second.id)
    end

    it 'リクエストが成功したら登録小説が１件保存されていること' do
      expect { post books_create_path, params: books_params }.to change(Book, :count).by(1)
    end

    it 'isbnが重複する場合はフラッシュメッセージが表示されること' do
      post books_create_path, params: bad_books_params
      expect(response.body).to include("すでに登録されている小説です。")
    end
  end

  describe 'GET /show' do
    before do
      get book_path(book)
    end

    it "リクエストに成功すること" do
      expect(response).to have_http_status(200)
    end

    it '小説の情報が正しく取得できること' do
      expect(response.body).to include(book.title)
      expect(response.body).to include(book.author)
      expect(response.body).to include(book.url)
      expect(response.body).to include(book.image_url)
    end
  end
end
