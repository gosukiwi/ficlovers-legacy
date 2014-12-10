class Tag < ActiveRecord::Base
  validates :name, presence: true, format: { with: /[^,]+/, message: 'tag name must contain no commas' }
  validates :context, presence: true, inclusion: { in: ['fandoms', 'characters'] }
  validates :status, presence: true, inclusion: { in: ['pending', 'active', 'removed'] }

  # tags
  has_many :taxonomies
  has_many :stories, through: :taxonomies

  scope :pending_tags, ->{
    where(status: 'pending').order(context: :asc, name: :asc)
  }

  def self.search(context, keyword)
    wcard_keyword = "%#{keyword}%"
    where("context = :context AND name LIKE :keyword AND status = 'active'", keyword: wcard_keyword, context: context)
  end
end
