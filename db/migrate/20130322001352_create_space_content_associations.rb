class CreateSpaceContentAssociations < ActiveRecord::Migration
  def self.up
     create_table :space_content_associations do |t|
      t.integer :space_id
      t.integer :content_id

      t.timestamps
    end
  end

  def self.down
    drop_table :space_content_associations
  end
end
