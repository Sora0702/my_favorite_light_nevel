require 'rails_helper'

RSpec.describe 'Narous', type: :request do
  let!(:narou) { create(:narou) }

  describe 'GET /index' do
    let!(:other_narou) { create(:narou, title: "二番目の", ncode: "2") }
    let(:narou_search_params) { { keyword: "二番目の" } }

    context '検索した場合' do
      before do
        get narous_path, params: narou_search_params
      end

      it '一覧画面に正常にアクセスできること' do
        expect(response).to have_http_status(200)
      end

      it 'keywordを含む小説の情報が正しく取得できること' do
        expect(response.body).to include(other_narou.title)
      end

      it 'keywordを含まない小説が取得されないこと' do
        expect(response.body).not_to include(narou.title)
      end
    end

    context '検索しない場合' do
      before do
        get narous_path
      end

      it '一覧画面に正常にアクセスできること' do
        expect(response).to have_http_status(200)
      end

      it '登録済みの小説の情報が全て正しく取得できること' do
        expect(response.body).to include(other_narou.title)
        expect(response.body).to include(other_narou.writer)
        expect(response.body).to include(narou.title)
        expect(response.body).to include(narou.writer)
      end
    end
  end

  describe 'GET /search' do
    let(:narou_search_params) { { keyword: "教室" } }

    context "検索に成功した場合" do
      before do
        get narous_search_path, params: narou_search_params
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
        get narous_search_path, params: { keyword: "" }
        expect(response).to have_http_status(200)
        expect(response.body).to include("小説のタイトルを入力してください。")
      end

      it "パラメータがnilの時, フラッシュメッセージが表示されること" do
        get narous_search_path, params: { keyword: nil }
        expect(response).to have_http_status(200)
        expect(response.body).to include("小説のタイトルを入力してください。")
      end
    end
  end

  describe 'POST narous' do
    let(:narous_params) { { narou: { title: "test", writer: "author", isbn: "12345" } } }
    let(:bad_narous_params) { { narou: { title: "test2", writer: "author", ncode: "n2854hc" } } }

    it 'リクエストが成功したらshowアクションにリダイレクトすること' do
      post narous_create_path, params: narous_params
      expect(response).to redirect_to narou_path(Narou.second.id)
    end

    it 'リクエストが成功したら登録小説が１件保存されていること' do
      expect { post narous_create_path, params: narous_params }.to change(Narou, :count).by(1)
    end

    it 'ncodeが重複する場合はフラッシュメッセージが表示されること' do
      post narous_create_path, params: bad_narous_params
      expect(response.body).to include("すでに登録されているweb小説です。")
    end
  end

  describe 'GET /show' do
    before do
      get narou_path(narou)
    end

    it "リクエストに成功すること" do
      expect(response).to have_http_status(200)
    end

    it '小説の情報が正しく取得できること' do
      expect(response.body).to include(narou.title)
      expect(response.body).to include(narou.writer)
      expect(response.body).to include(narou.story)
      expect(response.body).to include(narou.ncode)
    end
  end
end
