class Category < ActiveRecord::Base
  has_many :stories

  def to_string
    self.name
  end
end
