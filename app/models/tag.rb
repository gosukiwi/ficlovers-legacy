class Tag < ActiveRecord::Base
  validates :name, presence: true
  validates :context, presence: true, length: { maximum: 15 }, inclusion: { in: [:fandoms, :characters] }
end
