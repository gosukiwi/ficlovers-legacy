class Chapter < ActiveRecord::Base
  validates :story, presence: true
  validates :title, presence: true, length: { in: 5..100 }
  validates :content, presence: true, length: { minimum: 150 }

  belongs_to :story

  scope :ordered, ->{ order('`order` ASC') }
end
