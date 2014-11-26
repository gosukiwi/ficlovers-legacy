class Chapter < ActiveRecord::Base
  belongs_to :story

  validates :story, presence: true
  validates :title, presence: true, length: { in: 5..100 }
  validates :content, presence: true, length: { minimum: 150 }
end
