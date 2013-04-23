class ChangeColumnTimeToIntegerForUser < ActiveRecord::Migration
  def self.up
    remove_column :contents, :study_estimated_time
    add_column :contents, :study_estimated_time, :integer
  end

  def self.down
    remove_column :contents, :study_estimated_time
    add_column :contents, :study_estimated_time, :string
  end
end
