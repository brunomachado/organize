class AddLinkTypePublicAndStudyEstimatedTimeToContent < ActiveRecord::Migration
  def self.up
    add_column :contents, :link, :String
    add_column :contents, :type, :String
    add_column :contents, :study_estimated_time, :String
  end

  def self.down
    remove_column :contents, :study_estimated_time
    remove_column :contents, :type
    remove_column :contents, :link
  end
end
