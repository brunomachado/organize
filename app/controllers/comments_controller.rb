class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment])
    @comment.author = User.find(1)
    @comment.content = Content.find(params[:content_id])
    @comment.save

    redirect_to content_path(params[:content_id])
  end

  def answer

  end
end
