class User < ActiveRecord::Base
  include HasFollowers

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
  validates :password, length: { minimum: 6 }, on: :create
  validates :role, inclusion: { in: ['user', 'admin'] }

  has_many :stories
  has_many :favs
  has_many :favorites, through: :favs, source: :story
  has_many :posts
  has_many :notifications

  has_secure_password

  before_save :set_defaults

  def admin?
    role == 'admin'
  end

  def to_param
    username
  end

  protected

    def set_defaults
      self.email = email.downcase unless email == nil
      self.role ||= 'user'
    end
end
