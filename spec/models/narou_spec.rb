require 'rails_helper'

RSpec.describe Narou, type: :model do
  let!(:narou) { create(:narou) }
  let(:other_narou) { create(:narou, title: "test2", writer: "test2_author", ncode: "n5000hk") }

  describe 'narou' do
    it '有効な属性が登録された場合は、モデルが有効になっていること' do
      expect(narou).to be_valid
    end

    it 'ncodeがユニークであること' do
      duplicated_narou = Narou.new(ncode: "n2854hc")
      duplicated_narou.valid?
      expect(duplicated_narou.errors[:ncode]).to include("はすでに存在します")
    end
  end

  describe '#self.narou_search' do
    context '一致するデータがある場合' do
      it '検索文字列に部分一致する配列を返すこと' do
        expect(Narou.narou_search("titl")).to include(narou)
        expect(Narou.narou_search("writ")).to include(narou)
      end
    end

    context '一致するデータがない場合' do
      it '検索結果が一致しない場合には空の配列を返すこと' do
        expect(Narou.narou_search("テスト")).to be_empty
      end

      it '検索文字列が空白の場合は全ての配列を返すこと' do
        expect(Narou.narou_search("")).to include(narou)
        expect(Narou.narou_search("")).to include(other_narou)
      end
    end
  end
end
