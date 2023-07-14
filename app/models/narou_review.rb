class NarouReview < ApplicationRecord
  validates :content, presence: true, length: { maximum: 400 }
  belongs_to :narou
  belongs_to :user
end
