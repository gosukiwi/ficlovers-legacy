class Forum < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  enum status: [:open, :read_only]

  has_many :posts

  # make pretty URL's {id}-{title} format
  def to_param
    "#{id}-#{name.parameterize}"
  end
end
