# coding: utf-8
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

  attr_accessible :space_content_association, :link, :name,
    :kind, :description, :study_estimated_time

  classy_enum_attr :kind
  has_reputation :rating, source: :user, aggregated_by: :average
  MIN_RATING = 1
  MAX_RATING = 5

  def suggest!
    self.space_content_association.update_attributes({ status: 'suggested' })
  end

  def accept!
    self.space_content_association.update_attributes({ status: 'accepted' })
  end

  def reject!
    self.space_content_association.destroy
  end

  def belongs_to_space?(space)
    self.space.try(:id) == space.id
  end

  def belongs_to_user?(user)
    self.users.include?(user)
  end

  def self.is_valid_rating_value?(value)
    value.between?(MIN_RATING, MAX_RATING)
  end

  def get_rating_by(user)
    self.evaluations.where(source_id: user.id, source_type: "User",
                           reputation_name: "rating").first.value
  end

  def study_estimated_time
    time = read_attribute(:study_estimated_time)
    hour = time / 60
    minute = time % 60

    if (hour == 0 && minute == 0)
      "Desconhecido"
    else
      if hour > 0
        hour = "#{hour} horas "
      else
        hour = ""
      end

      "#{hour}#{minute} minutos"
    end
  end
end
