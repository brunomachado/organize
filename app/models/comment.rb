class Comment < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :content
  belongs_to :in_response_to, class_name: 'Comment'

  has_many :answers, foreign_key: 'in_response_to_id', dependent: :destroy

  validates_presence_of :author, :content, :body
  validates_length_of :body, minimum: 2
end
