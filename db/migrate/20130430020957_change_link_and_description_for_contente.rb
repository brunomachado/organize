class ChangeLinkAndDescriptionForContente < ActiveRecord::Migration
  def self.up
    change_column :contents, :link, :text
    change_column :contents, :description, :text
  end

  def self.down
    change_column :contents, :link, :string
    change_column :contents, :description, :string
  end
end
