class ChangeLastNameForRoleToUser < ActiveRecord::Migration
  def self.up
    rename_column :users, :last_name, :role
  end

  def self.down
    rename_column :users, :role, :last_name
  end
end
