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

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(params[:content])
    @user = User.find(1)
    @content.owner = @user

    if @content.save
      if params[:user_id]
        @user.contents << @content
        redirect_to user_contents_path
      elsif params[:space_id]
        Space.find(params[:space_id].to_s).contents << @content
        redirect_to space_contents_path
      end
    else
      render 'new'
    end
  end
end
