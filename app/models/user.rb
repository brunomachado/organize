class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :token, presence: true

  has_many :user_content_associations, dependent: :destroy
  has_many :contents, through: :user_content_associations

  attr_accessible :email, :name, :last_name, :token, :uid, :role

  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.token = auth["credentials"]["token"]
    end
  end

  def teacher?
    self.role == "teacher"
  end
end
