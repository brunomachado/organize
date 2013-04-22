class AddUidToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :uid, :Integer
  end

  def self.down
    remove_column :users, :uid, :Integer
  end
end
