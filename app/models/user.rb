class User < ActiveRecord::Base
  has_many :stories

  has_many :favs
  has_many :favorites, through: :favs, source: :story

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 50 }
  validates :password, length: { minimum: 6 }
  validates :role, inclusion: { in: ['user', 'admin'] }

  before_save do
    self.email = email.downcase
    self.role ||= 'user'
  end

  def admin?
    role == 'admin'
  end

  # Add a story to this user favs
  def add_to_fav(story)
    raise 'Invalid story' unless story.valid?
    begin
      favorites << story
      return true if save
    rescue
      false
    end
  end

end
