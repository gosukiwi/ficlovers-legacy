# A forum post
class Post < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :content, presence: true, length: { minimum: 50 }

  belongs_to :user
  belongs_to :forum
  has_many :replies
  has_one :story
  has_and_belongs_to_many :watchers, join_table: :users_posts, class_name: 'User'

  # Used to generate notifications
  has_many :notifications, as: :notificables

  after_create do
    user.increment! :post_count
  end

  scope :latest, ->{ order('id DESC') }
  scope :sorted, ->{ order('pinned DESC, id DESC') }

  def increment_views
    self.increment! :views
  end

  # make pretty URL's {id}-{title} format
  def to_param
    "#{id}-#{title.parameterize}"
  end

  def pin
    self.pinned = true
    save
  end

  def unpin
    self.pinned = false
    save
  end

  def pinned?
    pinned
  end
end
