class Review < ApplicationRecord
  validates :content, presence: true, length: { maximum: 400 }
  belongs_to :book
  belongs_to :user
end
