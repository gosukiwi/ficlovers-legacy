class PrivateMessage < ActiveRecord::Base
  validates :message, presence: true

  belongs_to :receiver, foreign_key: :receiver_id, class_name: 'User'
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
end
