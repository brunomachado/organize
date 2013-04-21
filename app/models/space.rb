class Space < ActiveRecord::Base
  validates :name, presence: true

  has_many :space_content_associations, dependent: :destroy
  has_many :contents, through: :space_content_associations
end
