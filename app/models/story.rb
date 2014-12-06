class Story < ActiveRecord::Base
  belongs_to :category
  has_many :chapters, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { in: 5..100 }
  validates :summary, presence: true, length: { in: 50..250 }

  # Find hot stories
  # TODO: Fetch most viewed/liked latest (< 1 week) stories
  def self.hot
    self.all
  end
  
  def increment_views
    self.views = self.views + 1
    save
  end
end
