class Notification < ActiveRecord::Base
  validates :message, presence: true
  belongs_to :user

  scope :sorted, ->{ order('id DESC') }
end
