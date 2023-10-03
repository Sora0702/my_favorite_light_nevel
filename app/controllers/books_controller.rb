class BooksController < ApplicationController
  def search
    if params[:keyword].present?
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
      @book = Book.new
    else
      flash.now[:alert] = "小説のタイトルを入力してください。"
      render :search
    end
  end

  def create
    book_isbn = book_params[:isbn]
    @book = Book.new(book_params)
    @books = Book.all
    if @book.save
      flash[:notice] = "小説を登録しました。"
      redirect_to @book
    else
      @book = Book.find_by(isbn: book_isbn)
      redirect_to @book
    end
  end

  def index
    if params[:keyword]
      @books = Book.search(params[:keyword])
    else
      @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
    @review = @book.reviews.new
    @reviews = @book.reviews.order(created_at: :desc)
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :isbn, :url, :image_url)
  end
end
