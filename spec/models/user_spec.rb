require 'spec_helper'

describe User do
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:token) }
  end

  context "associations" do
    it { should have_many :contents }
    it { should have_many(:user_content_associations).dependent :destroy }
  end
end
