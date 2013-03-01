class AddLastNameEmailAndTokenToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :last_name, :String
    add_column :users, :email, :String
    add_column :users, :token, :String
  end

  def self.down
    remove_column :users, :token
    remove_column :users, :email
    remove_column :users, :last_name
  end
end
