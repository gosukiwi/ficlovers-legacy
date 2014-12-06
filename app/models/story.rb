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
  scope :hot, ->{
    select('stories.*, count(favs.id) as favs_count')
      .joins('LEFT JOIN `favs` ON `favs`.story_id = `stories`.id')
      .group('stories.id')
      .order('favs_count DESC, stories.views DESC')
      .where('created_at >= :one_week_ago', { one_week_ago: 1.week.ago })
  }

  def increment_views
    self.views = self.views + 1
    save
  end

  # Add a story to this user favs
  def add_to_fav(user)
    return 'Invalid story' unless valid?
    return 'Oops, cannot fav your own story!' unless self.user != user

    begin
      user.favorites << self
      return user.save ? 'Faved!' : 'Please try again'
    rescue
      user.favorites.delete self
      return 'Unfaved'
    end
  end

end
