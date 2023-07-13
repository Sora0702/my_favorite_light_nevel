require 'rails_helper'

RSpec.describe Book, type: :model do
  let!(:book) { create(:book) }
  let(:other_book) { create(:book, title: "test2", author: "test2_author", isbn: 234) }

  describe 'book' do
    it '有効な属性が登録された場合は、モデルが有効になっていること' do
      expect(book).to be_valid
    end

    it 'isbnがユニークであること' do
      duplicated_book = Book.new(isbn: 1234)
      duplicated_book.valid?
      expect(duplicated_book.errors[:isbn]).to include("はすでに存在します")
    end
  end

  describe '#self.search' do
    context '一致するデータがある場合' do
      it '検索文字列に部分一致する配列を返すこと' do
        expect(Book.search("titl")).to include(book)
        expect(Book.search("auth")).to include(book)
      end
    end

    context '一致するデータがない場合' do
      it '検索結果が一致しない場合には空の配列を返すこと' do
        expect(Book.search("テスト")).to be_empty
      end

      it '検索文字列が空白の場合は全ての配列を返すこと' do
        expect(Book.search("")).to include(book)
        expect(Book.search("")).to include(other_book)
      end
    end
  end
end
