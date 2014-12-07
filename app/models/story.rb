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

  def character_tags
    tags.where(status: 'active', context: 'characters')
  end

  def fandom_tags
    tags.where(status: 'active', context: 'fandoms')
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

    def fetch_tags(context, names)
      return [] if names == nil
      names.map { |name| Tag.find_by(name: name, context: context) || Tag.new(name: name, context: context) }
    end

end
