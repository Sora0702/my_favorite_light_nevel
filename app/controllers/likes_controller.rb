class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    current_user.like(@book)
  end

  def destroy
    @book = current_user.like_books.find(params[:id])
    current_user.unlike(@book)
  end
end
