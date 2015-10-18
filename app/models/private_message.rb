class PrivateMessage < ActiveRecord::Base
  validates :message, presence: true

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

private

  def role_for(user)
    return :receiver if user == receiver
    return :author   if user == author
    raise 'Invalid user'
  end
end
