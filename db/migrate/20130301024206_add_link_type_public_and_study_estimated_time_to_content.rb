class AddLinkTypePublicAndStudyEstimatedTimeToContent < ActiveRecord::Migration
  def self.up
    add_column :contents, :link, :string
    add_column :contents, :type, :string
    add_column :contents, :study_estimated_time, :string
  end

  def self.down
    remove_column :contents, :study_estimated_time
    remove_column :contents, :type
    remove_column :contents, :link
  end
end
