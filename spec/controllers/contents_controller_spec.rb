require 'spec_helper'

describe ContentsController do
  context "GET index" do
    let(:user) { create(:user) }
    let(:content) { create(:content) }

    before do
      user.contents << content
      get :index, :user_id => user
    end

    it { response.should render_template 'contents/index' }

    it "should assigns user" do
      assigns[:user].should_not be_nil
      assigns[:user].should == user
    end

    it "should assigns contents" do
      assigns[:contents].should_not be_nil
      assigns[:contents].should == user.contents
    end
  end
end
