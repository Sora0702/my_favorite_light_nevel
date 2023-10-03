class NarouLike < ApplicationRecord
  belongs_to :user
  belongs_to :narou

  validates :user_id, uniqueness: { scope: :narou_id }, presence: true
  validates :narou_id, presence: true
end
