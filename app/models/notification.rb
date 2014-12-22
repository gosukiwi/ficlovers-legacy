class Notification < ActiveRecord::Base
  validates :message, presence: true
  validates :action, presence: true

  belongs_to :user
end
