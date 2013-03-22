class User < ActiveRecord::Base
  validates :name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :token, presence: true

  has_many :links, through: :user_content_association
end
