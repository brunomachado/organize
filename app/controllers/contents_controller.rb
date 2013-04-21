class ContentsController < ApplicationController
  def index
    if params[:user_id]
      @user = User.find(params[:user_id].to_s)
      @contents = @user.contents
    elsif params[:space_id]
      @space = Space.find(params[:space_id].to_s)
      @contents = @space.contents
    end
  end
end
