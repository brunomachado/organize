class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :content
      t.belongs_to :in_response_to
      t.text :body

      t.timestamps
    end
  end

  def down
    drop_table :comments
  end
end
