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
      .where('created_at >= :one_week_ago', { one_week_ago: 1.week.ago })
  }

  def self.search(options)
    query = select('stories.*')
      .joins('JOIN `taxonomies` ON `taxonomies`.`story_id` = `stories`.id')
      .joins('JOIN `tags` ON `taxonomies`.tag_id = `tags`.id')

    query = query.where(category_id: options[:category]) unless options[:category] == '0'

    # given a hash of tags (options[:fandoms], options[:characters], etc) parse
    # them into { where: 'STMT1 OR STMT2 OR...', [query_arg1, query_arg_2], ... }
    having = parse_tags(options[:tags])
    return query
      .group('stories.id')
      .having(having[:stmt], *having[:args])
      .includes([:category, :tags])
  end

  def active_tags
    tags.where(status: 'active')
  end

  # right now there are two types of tagging
  def set_tags(tags)
    tag_list = tags.map do |tag|
      tag = tag[1]
      Tag.find_or_create_by(name: tag[0], context: tag[1] || 'pending')
    end
    self.tags = tag_list
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

  private

    # Helper method used by search, transforms a comma-separated string of tags
    # into matching SQL OR clauses
    def self.parse_tags(tags) 
      clauses = []
      args = []
      tags.each do |tag|
        clauses << "SUM(`tags`.name LIKE ?) > 0"
        args << "%#{tag[0]}%"
      end
      return { stmt: clauses.join(' AND '), args: args }
    end
end
