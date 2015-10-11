class Chapter < ActiveRecord::Base
  validates :story, presence: true
  validates :title, presence: true, length: { in: 5..100 }
  validates :content, presence: true, length: { minimum: 150 }

  # `touch` allows us to bump story updated_at whenever this gets updated
  belongs_to :story, touch: true

  scope :ordered, ->{ order('`order` ASC') }
end
