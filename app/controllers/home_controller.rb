class HomeController < ApplicationController
  def top
    @reviews = Review.all.order(created_at: :desc).limit(5)
  end
end
