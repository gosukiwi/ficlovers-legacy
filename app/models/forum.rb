class Forum < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  has_many :posts

  def sorted_posts
    posts.order('pinned DESC, id DESC')
  end

  # make pretty URL's {id}-{title} format
  def to_param
    "#{id}-#{name.parameterize}"
  end
end
