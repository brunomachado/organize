class ContentsController < ApplicationController
  def index
    if params[:space_id]
      @space = current_space
      @contents = @space.contents
    else
      @user = current_user
      @contents = @user.contents
    end
  end

  def show
    @content = Content.find(params[:id].to_s)
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
        @content.accept!
        redirect_to space_contents_path
      end
    else
      render 'new'
    end
  end

  def suggest_for
    @content = Content.find(params[:content_id].to_s)
    @space = Space.find(params[:space_id].to_s)

    unless @space.contents.include? @content
      @space.contents << @content
      @content.suggest!
    end

    redirect_to space_contents_path(1)
  end

  def add_to
    @content = Content.find(params[:content_id].to_s)
    @content.accept!

    redirect_to space_contents_path(1)
  end
end
