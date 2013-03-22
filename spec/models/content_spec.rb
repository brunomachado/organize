require 'spec_helper'

describe Content do
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:link) }
    it { should validate_presence_of(:type) }

    it { should validate_uniqueness_of(:link) }
  end

  context "associations" do
    it { should belong_to :owner }
    it { should have_many :users }
    it { should have_one :space }
  end
end
