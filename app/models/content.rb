class Content < ActiveRecord::Base
  validates :name, :presence: true
end
