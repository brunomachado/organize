class SpaceContentAssociation < ActiveRecord::Base
  belongs_to :space
  belongs_to :content
end
