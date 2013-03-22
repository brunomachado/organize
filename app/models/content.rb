class Content < ActiveRecord::Base
  validates :name, presence: true
  validates :type, presence: true
  validates :link, presence: true, uniqueness: true

  belongs_to :owner, class_name: "User", foreign_key: "user_id"

  has_one :space, through: :space_content_association
  has_many :users, through: :user_content_association
end
