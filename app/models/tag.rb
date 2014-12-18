class Tag < ActiveRecord::Base
  validates :name, presence: true, format: { with: /[^,]+/, message: 'tag name must contain no commas' }
  validates :context, presence: true, inclusion: { in: ['fandoms', 'characters', 'genres', 'pending'] }
  validates :status, presence: true, inclusion: { in: ['pending', 'active', 'removed'] }

  # tags
  has_many :taxonomies
  has_many :stories, through: :taxonomies

  scope :pending, ->{
    where(status: 'pending').order(context: :asc, name: :asc)
  }

  scope :active, ->{
    where(status: 'active').order(context: :asc, name: :asc)
  }

  after_initialize do
    self.context = 'pending' unless attribute_present? 'context'
  end

  before_save do
    raise 'Cannot activate a tag with a "pending" context' if self.status == 'active' && self.context == 'pending'
  end

  def to_s
    "#{name} (#{context})"
  end

  def self.search(keyword)
    wcard_keyword = "%#{keyword}%"
    where("name LIKE :keyword AND status = 'active'", keyword: wcard_keyword)
  end
end
