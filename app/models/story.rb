class Story < ActiveRecord::Base
  belongs_to :category
  has_many :chapters, dependent: :destroy
  belongs_to :user
  # favs
  has_many :favs
  has_many :favorited_by, through: :favs, source: :user
  # tags
  has_many :taxonomies
  has_many :tags, through: :taxonomies

  validates :title, presence: true, length: { in: 5..100 }
  validates :summary, presence: true, length: { in: 50..250 }

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

  def self.search(options)
    query = select('stories.*')
      .joins('JOIN `taxonomies` ON `taxonomies`.`story_id` = `stories`.id')
      .joins('JOIN `tags` ON `taxonomies`.tag_id = `tags`.id')

    query = query.where(category_id: options[:category]) unless options[:category] == '0'

    # given an array of tags, parse them into HAVING statements joined by ANDs
    # also return an array with all the prepared statement's parameters
    # returns something which looks like
    # { stmt: 'COUNT(?) > 0 AND COUNT(?) > 0 ...', args: [arg1, arg2, ...] }
    having = parse_tags(options[:tags])
    return query
      .where('`tags`.status = "active" and `stories`.published <> 0')
      .group('stories.id')
      .having(having[:stmt], *having[:args])
      .includes([:category, :tags])
  end

  def published?
    self.published
  end

  def active_tags
    tags.where(status: 'active').order('context desc, name asc')
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

  # make pretty URL's {id}-{title} format
  def to_param
    "#{id}-#{title.parameterize}"
  end

  private

    # Helper method used by search, transforms a comma-separated string of tags
    # into matching SQL OR clauses
    def self.parse_tags(tags) 
      clauses = []
      args = []
      tags.each do |tag|
        clauses << "SUM(`tags`.name = ?) > 0"
        args << tag[0]
      end
      return { stmt: clauses.join(' AND '), args: args }
    end
end
