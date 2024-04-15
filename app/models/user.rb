class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :items
  has_many :histories

  # バリデーション
  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 },
                       format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'Include both letters and numbers' }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: 'Input full-width characters' }
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: 'Input full-width characters' }
  validates :first_name_kana, presence: true,
                              format: { with: /\A[ァ-ン]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :last_name_kana, presence: true,
                             format: { with: /\A[ァ-ン]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :birth_date, presence: true
end
