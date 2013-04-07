class ContentsController < ActionController::Base
  def index
    @user = User.find(params[:user_id].to_s)
    @contents = @user.contents

    respond_to do |format|
      format.html { render :layout => 'application' }
    end
  end
end
