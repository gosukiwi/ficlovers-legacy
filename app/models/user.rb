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
  has_and_belongs_to_many :watched_posts, join_table: :users_posts, class_name: 'Post'

  has_secure_password

  before_save :set_defaults

  def admin?
    role == 'admin'
  end

  def to_param
    username
  end

  def watch_toggle(post)
    begin
      watch post
    rescue ActiveRecord::RecordNotUnique
      unwatch post
    end
  end

  def watch(post)
    watched_posts << post
  end

  def unwatch(post)
    watched_posts.delete post
  end

  def watches?(post)
    return watched_posts.include? post
  end

  protected

    def set_defaults
      self.email = email.downcase unless email == nil
      self.role ||= 'user'
    end
end
