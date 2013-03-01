class Space < ActiveRecord::Base
  validates :name, presence: true
end
