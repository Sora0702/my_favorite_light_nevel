class Novel < ApplicationRecord
  validates :novel_name, presence: true
  validates :category, presence: true
  validates :author, presence: true
  validates :impression, presence: true, length: { maximum: 400 }
  belongs_to :user
end
