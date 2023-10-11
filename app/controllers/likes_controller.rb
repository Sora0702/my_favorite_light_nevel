class LikesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    current_user.like(@book)
  end

  def destroy
    @book = current_user.like_books.find(params[:id])
    current_user.unlike(@book)
    respond_to do |format|
      format.html
        render 'users/profile'
      format.json
    end
  end
end
