class UserContentAssociation < ActiveRecord::Base
  belongs_to :user
  belongs_to :content
end
