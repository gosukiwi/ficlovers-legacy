# A forum post
class Post < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :content, presence: true, length: { minimum: 50 }
  belongs_to :user
  belongs_to :forum
  has_many :replies

  def paginated_replies(page, per_page = 10)
    replies.order('id ASC').paginate(page: page, per_page: per_page)
  end

  # make pretty URL's {id}-{title} format
  def to_param
    "#{id}-#{title.parameterize}"
  end
end
