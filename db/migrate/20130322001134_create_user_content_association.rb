class CreateUserContentAssociation < ActiveRecord::Migration
  def self.up
     create_table :user_content_associations do |t|
      t.integer :user_id
      t.integer :content_id
      t.boolean :public

      t.timestamps
    end
  end

  def self.down
    drop_table :user_content_associations
  end
end
