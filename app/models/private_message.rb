class PrivateMessage < ActiveRecord::Base
  validates :message, presence: true
  validates :title, presence: true
  validates :receiver, presence: true
  validates :author, presence: true
  validate  :check_sender_is_not_receiver

  belongs_to :receiver, foreign_key: :receiver_id, class_name: 'User'
  belongs_to :author, foreign_key: :author_id, class_name: 'User'

  # Used to generate notifications
  has_many :notifications, as: :notificables

  enum deleted_by: [:nobody, :author, :receiver]

  scope :sorted, ->{ order(id: :desc) }
  scope :for_authors, -> { where.not(deleted_by: deleted_bies[:author]) }
  scope :for_receivers, -> { where.not(deleted_by: deleted_bies[:receiver]) }

  def destroy_as(user)
    if nobody?
      update(deleted_by: role_for(user))
    else
      destroy
    end
  end

  # Builds a new PM instance which is a reply to this one
  def build_reply
    new_pm = PrivateMessage.new
    new_pm.author   = receiver
    new_pm.receiver = author
    new_pm.title    = 'RE: ' + title
    new_pm.message  = '> ' + message.gsub("\n", "\n> ") + "\n"
    new_pm
  end

private

  def check_sender_is_not_receiver
    errors.add(:receiver, 'Cannot send yourself a message') if receiver == author
  end

  def role_for(user)
    return :receiver if user == receiver
    return :author   if user == author
    raise 'Invalid user'
  end
end
