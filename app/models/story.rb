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

    # given a hash of tags (options[:fandoms], options[:characters], etc) parse
    # them into { ors: 'STMT1 OR STMT2 OR...', [query_arg1, query_arg_2], ... }
    tags = parse_tags(options)
    return query.where(tags[:ors], *tags[:args]).uniq.includes([:category, :tags])
  end

  def active_tags
    tags.where(status: 'active')
  end

  # right now there are two types of tagging
  def set_tags(fandom_names, character_names)
    tag_list = fetch_tags('fandoms', fandom_names)
    tag_list += fetch_tags('characters', character_names)
    # clear tags and set new list
    self.tags.clear
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

    # Given a context a list of names, find all tag objects by that name in the
    # given context
    def fetch_tags(context, names)
      return [] if names == nil
      names.map { |name| Tag.find_by(name: name, context: context) || Tag.new(name: name, context: context) }
    end


    # Helper method used by search, transforms a comma-separated string of tags
    # into matching SQL OR clauses
    def self.parse_tags(options) 
      fandoms = self.parse_tag_context options[:fandoms], 'fandoms'
      characters = self.parse_tag_context options[:characters], 'characters'
      fandoms[:ors] = fandoms[:ors].concat(characters[:ors]).join(' OR ')
      fandoms[:args].concat(characters[:args])
      return fandoms
    end

    def self.parse_tag_context(tag_string, context)
      tags = { ors: [], args: [] }
      tag_string.split(',').each do |term|
        tags[:ors] << '(`tags`.context = ? AND `tags`.name LIKE ?)'
        tags[:args].concat [context, "%#{term}%"]
      end
      return tags
    end
end
