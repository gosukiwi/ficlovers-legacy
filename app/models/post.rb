# A forum post
class Post < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :content, presence: true, length: { minimum: 50 }
  belongs_to :user
  belongs_to :forum
end
