class Reply < ActiveRecord::Base
  validates :content, presence: true, length: { minimum: 50 }
  belongs_to :user
  belongs_to :post

  scope :sorted, ->{ order('id ASC') }

  delegate :forum, to: :post

  after_create do
    user.increment! :post_count
  end
end
