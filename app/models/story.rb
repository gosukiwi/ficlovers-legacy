class Story < ActiveRecord::Base
  validates :title, presence: true, length: { in: 5..100 }
  validates :summary, presence: true, length: { in: 50..250 }

  belongs_to :category
  has_many :chapters, dependent: :destroy
  belongs_to :user
  # favs
  has_many :favs
  has_many :favorited_by, through: :favs, source: :user
  # tags
  has_many :taxonomies
  has_many :tags, through: :taxonomies
  # forum
  belongs_to :post

  after_create do
    self.post = Post.create({
      title: "Fic discussion: [#{self.title}]",
      content: "Please discuss \"#{self.title}\" below. Please be respectful and remember to provide constructive feedback.",
      user: user,
      forum: Forum.find_or_create_by(name: 'Fic Discussion')
    })
  end

  # Find hot stories
  scope :hot, ->{
    select('stories.*, count(favs.id) as favs_count')
      .joins('LEFT JOIN `favs` ON `favs`.story_id = `stories`.id')
      .group('stories.id')
      .order('favs_count DESC, stories.views DESC')
      .where('created_at >= :one_week_ago and published <> 0', { one_week_ago: 1.week.ago })
  }

  scope :fresh, ->{
    where('published <> 0').order('updated_at desc')
  }

  def active_tags
    tags.where(status: 'active').order('context desc, name asc')
  end

  def published?
    self.published
  end

  # Takes an array of [:name, :context?] and sets the appropiate tagging for
  # this story. Ignores tags which are flagged as 'removed'.
  def set_tags(tag_list)
    self.tags = tag_list
      .reject{ |tag| Tag.exists?(name: tag[0], context: 'removed') }
      .map{ |tag| Tag.find_or_create_by(name: tag[0], context: tag[1] || 'pending') }
    save
  end

  def increment_views
    self.increment! :views
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

  # make pretty URL's {id}-{title} format
  def to_param
    "#{id}-#{title.parameterize}"
  end
end
