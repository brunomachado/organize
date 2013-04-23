class AddStatusToAssociations < ActiveRecord::Migration
  def self.up
    add_column :space_content_associations, :status, :string
  end

  def self.down
    remove_column :space_content_associations, :status, :string
  end
end
