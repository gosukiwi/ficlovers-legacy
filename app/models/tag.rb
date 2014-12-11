class Tag < ActiveRecord::Base
  validates :name, presence: true, format: { with: /[^,]+/, message: 'tag name must contain no commas' }
  validates :context, presence: true, inclusion: { in: ['fandoms', 'characters', 'pending'] }
  validates :status, presence: true, inclusion: { in: ['pending', 'active', 'removed'] }

  after_initialize do
    self.context = 'pending' unless attribute_present? 'context'
  end

  # tags
  has_many :taxonomies
  has_many :stories, through: :taxonomies

  scope :pending_tags, ->{
    where(status: 'pending').order(context: :asc, name: :asc)
  }

  def self.search(keyword)
    wcard_keyword = "%#{keyword}%"
    where("name LIKE :keyword AND status = 'active'", keyword: wcard_keyword)
  end
end
