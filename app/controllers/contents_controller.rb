class ContentsController < ApplicationController
  def root
    current_space
    client = ReduClient.new(current_user.token, current_space.uid)
    client.update_role(current_user.uid)
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
      reputations = Content.find_with_reputation(:rating, :all, order: 'rating desc')
      @contents = reputations & @contents
    elsif params[:time]
      @contents = @contents.order(:study_estimated_time)
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
      flash[:notice] = "O link <strong>#{@content.name}</strong> foi adicionado."

      if params[:add_link_to_space]
        Space.find(params[:space_id].to_s).contents << @content
        @content.accept!

        if params[:post_wall]
          client = ReduClient.new(current_user.token, current_space.uid)
          client.post_wall_space(params[:redu_lecture_id])
        end

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

  def add_mine
    @content = Content.find(params[:content_id].to_s)
    @user = current_user
    @user.contents << @content

    flash[:notice] = "O link <strong>#{@content.name}</strong> foi adicionado aos seus links."
    redirect_to content_path(@content)
  end

  def add_to
    @content = Content.find(params[:content_id].to_s)
    @contents = current_space.contents

    case params[:commit]
    when "recusar"
      @content.reject!
    when "aceitar"
      @content.accept!
    end

    respond_to do |format|
      format.js do
        render 'contents/moderate_suggestion'
      end
    end
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
