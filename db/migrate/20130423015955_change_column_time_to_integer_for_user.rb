class ChangeColumnTimeToIntegerForUser < ActiveRecord::Migration
  def self.up
    change_column :contents, :study_estimated_time, :integer
  end

  def self.down
    change_column :contents, :study_estimated_time, :string
  end
end
