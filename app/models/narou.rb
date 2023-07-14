class Narou < ApplicationRecord
  validates :ncode, uniqueness: true
  has_many :narou_reviews

  def self.narou_search(search)
    Narou.where("title LIKE(?) or writer LIKE(?)", "%#{search}%", "%#{search}%")
  end
end
