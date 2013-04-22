class Content < ActiveRecord::Base
  validates :name, presence: true
  validates :kind, presence: true
  validates :link, presence: true, uniqueness: true

  belongs_to :owner, class_name: "User", foreign_key: "user_id"

  has_one :space_content_association, dependent: :destroy
  has_one :space, through: :space_content_association

  has_many :user_content_associations, dependent: :destroy
  has_many :users, through: :user_content_associations
  has_many :comments

  classy_enum_attr :kind

  def suggest!
    self.space_content_association.update_attributes({ status: 'suggested' })
  end

  def accept!
    self.space_content_association.update_attributes({ status: 'accepted' })
  end

  def belongs_to_space?(space)
    self.space.id == space.id
  end
end
