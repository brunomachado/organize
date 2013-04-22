class ContentsController < ApplicationController
  def root
    redirect_to contents_path
  end

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
    @user = current_user
    @content.owner = @user

    if @content.save
      if params[:space_id]
        Space.find(params[:space_id].to_s).contents << @content
        @content.accept!
      else
        @user.contents << @content
      end
        redirect_to contents_path
    else
      render 'new'
    end
  end

  def suggest_for
    @content = Content.find(params[:content_id].to_s)
    @space = Space.find(params[:space_id].to_s)

    unless @content.belongs_to_space? @space
      @space.contents << @content
      @content.suggest!
    end

    respond_to do |format|
      format.js do
        render 'contents/confirm_suggest'
      end
    end
  end

  def add_to
    @content = Content.find(params[:content_id].to_s)
    @content.accept!

    redirect_to space_contents_path(1)
  end
end
