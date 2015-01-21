class WallMessage < ActiveRecord::Base
  validates :content, presence: true, length: { minimum: 5, maximum: 250 }

  belongs_to :receiver, foreign_key: :receiver_id, class_name: 'User'
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
end
