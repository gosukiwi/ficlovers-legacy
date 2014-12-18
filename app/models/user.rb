class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 50 }
  validates :password, length: { minimum: 6 }, on: :create
  validates :role, inclusion: { in: ['user', 'admin'] }

  has_many :stories

  has_many :favs
  has_many :favorites, through: :favs, source: :story

  has_many :posts

  has_secure_password

  before_save do
    self.email = email.downcase unless email == nil
    self.role ||= 'user'
  end

  def admin?
    role == 'admin'
  end
end
