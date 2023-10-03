class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :image
  validates :name, presence: true
  validates :introduction, length: { maximum: 300 }
  has_many :reviews, dependent: :destroy
  has_many :narou_review, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_books, through: :likes, source: :book
  has_many :narou_likes, dependent: :destroy
  has_many :narou_like_narous, through: :narou_likes, source: :narou

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.name = "ゲストユーザー"
      user.introduction = "ゲストユーザーでログイン中です。"
    end
  end

  def like(book)
    like_books << book
  end

  def unlike(book)
    like_books.destroy(book)
  end

  def like?(book)
    like_books.include?(book)
  end

  def narou_like(narou)
    narou_like_narous << narou
  end

  def narou_unlike(narou)
    narou_like_narous.destroy(narou)
  end

  def narou_like?(narou)
    narou_like_narous.include?(narou)
  end
end
