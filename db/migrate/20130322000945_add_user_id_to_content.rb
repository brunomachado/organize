class AddUserIdToContent < ActiveRecord::Migration
  def self.up
    add_column :contents, :user_id, :integer
  end

  def self.down
    remove_column :contents, :user_id
  end
end
