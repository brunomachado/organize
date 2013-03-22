class RenameTypeToKindInContent < ActiveRecord::Migration
  def self.up
    rename_column :contents, :type, :kind
  end

  def self.down
    rename_column :contents, :kind, :type
  end
end
