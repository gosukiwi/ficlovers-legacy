class Reply < ActiveRecord::Base
  validates :content, presence: true, length: { minimum: 50 }
  belongs_to :user
  belongs_to :post
end
