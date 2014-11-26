class Story < ActiveRecord::Base
  belongs_to :category
  has_many :chapters, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { in: 5..100 }
  validates :summary, presence: true, length: { in: 50..250 }
end
