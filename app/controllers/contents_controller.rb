class ContentsController < ApplicationController
  def root
    redirect_to contents_path
  end

  def index
    if params[:space_id]
      @user = current_user
      @space = current_space
      @contents = @space.contents
      @suggestions = @space.suggestions
    else
      @user = current_user
      @contents = @user.contents
    end

    if params[:bests]
      @contents = @contents.find_with_reputation(:rating, :all, order: 'rating desc')
    else
      @contents = @contents.order(:created_at).reverse_order
    end
  end

  def show
    @content = Content.find(params[:id].to_s)
    @content_rating = @content.reputation_for(:rating)
    @evaluations = @content.evaluators_for(:rating).count
    @evaluated = @content.has_evaluation?(:rating, current_user)
    @user_rating = @content.get_rating_by(current_user) if @evaluated
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(params[:content])
    @user = current_user
    @content.owner = @user

    if @content.save
      if params[:add_link_to_space]
        Space.find(params[:space_id].to_s).contents << @content
        @content.accept!
        redirect_to space_contents_path(current_space)
      else
        @user.contents << @content
        redirect_to contents_path
      end
    else
      render 'new'
    end
  end

  def suggest_for
    @content = Content.find(params[:content_id].to_s)
    @space = current_space

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

    case params[:commit]
    when "recusar"
      @content.reject!
    when "aceitar"
      @content.accept!
    end

    render :js => "window.location = '#{ space_contents_path(current_space) }'"
  end

  def rate
    rating = Integer(params[:rating])
    @content = Content.find(params[:content_id])
    @content.add_or_update_evaluation(:rating, rating, current_user)
    @user_rating = rating
    @content_rating = @content.reputation_for(:rating)
    @evaluated = true
    @evaluations = @content.evaluators_for(:rating).count

    respond_to do |format|
      format.js
    end
  end
end
