class Notification < ActiveRecord::Base
  validates :message, presence: true
  belongs_to :user
  belongs_to :notificable, polymorphic: true

  scope :sorted, ->{ order('id DESC') }
end
