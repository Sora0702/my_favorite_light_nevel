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
    @book = Book.new(book_params)
    @books = Book.all
    if @book.save
      flash[:notice] = "小説を登録しました。"
      redirect_to @book
    else
      flash.now[:alert] = "すでに登録されている小説です。"
      render :index
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
