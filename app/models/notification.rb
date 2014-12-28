class Notification < ActiveRecord::Base
  validates :message, presence: true
  belongs_to :user

  def self.notify(user)
    message = yield user
    Notification.create(user: user, message: message, read: false)
  end
end
