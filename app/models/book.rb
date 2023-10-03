class Book < ApplicationRecord
  validates :isbn, uniqueness: true
  has_many :reviews
  has_many :likes, dependent: :destroy
  has_many :narou_likes, dependent: :destroy
  has_many :users, through: :likes

  def self.search(search)
    Book.where("title LIKE(?) or author LIKE(?)", "%#{search}%", "%#{search}%")
  end
end
