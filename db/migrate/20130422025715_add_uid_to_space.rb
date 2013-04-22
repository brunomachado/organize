class AddUidToSpace < ActiveRecord::Migration
  def self.up
    add_column :spaces, :uid, :Integer
  end

  def self.down
    remove_column :spaces, :uid, :Integer
  end
end
