class Story < ActiveRecord::Base
  belongs_to :category
  has_many :chapters, dependent: :destroy
  belongs_to :user
  # favs
  has_many :favs
  has_many :favorited_by, through: :favs, source: :user

  validates :title, presence: true, length: { in: 5..100 }
  validates :summary, presence: true, length: { in: 50..250 }

  # Find hot stories
  # TODO: Fetch most viewed/liked latest (< 1 week) stories
  def self.hot(limit = 10)
    self.order(views: :desc, created_at: :desc).limit(limit)
  end
  
  def increment_views
    self.views = self.views + 1
    save
  end
end
