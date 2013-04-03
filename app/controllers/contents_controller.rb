class ContentsController < ActionController::Base
  def index
    @user = User.find(params[:user_id].to_s)
    @contents = @user.contents
  end
end
