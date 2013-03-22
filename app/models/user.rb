class User < ActiveRecord::Base
  validates :name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :token, presence: true

  has_many :user_content_associations, dependent: :destroy
  has_many :contents, through: :user_content_associations
end
