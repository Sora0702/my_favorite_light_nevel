class Book < ApplicationRecord
  validates :isbn, uniqueness: true
  has_many :reviews

  def self.search(search)
    Book.where("title LIKE(?) or author LIKE(?)", "%#{search}%", "%#{search}%")
  end
end
