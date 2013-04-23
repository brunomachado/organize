class AddLastNameEmailAndTokenToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :last_name, :string
    add_column :users, :email, :string
    add_column :users, :token, :string
  end

  def self.down
    remove_column :users, :token
    remove_column :users, :email
    remove_column :users, :last_name
  end
end
