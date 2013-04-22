class BaseController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :current_space
  before_filter :log_current_user

  protected

  # Gets possible loged in user from session
  def session_user
    return @session_user if defined? @session_user
    if session.has_key? :user_id
      @session_user ||= User.find_by_id(session[:user_id])
    end
  end

  # Verifies if the loged in user is the same passed by the canvas provider
  def current_user
    return @current_user if defined? @current_user
    return session_user unless params[:redu_user_id]

    user_id = params[:redu_user_id]
    if session_user.try(:uid) == user_id.try(:to_i)
      @current_user ||= session_user
    end
  end

  def session_space
    return @session_space if defined? @session_space
    if session.has_key? :space_id
      @session_space ||= Space.find_by_id(session[:space_id])
    end
  end

  def current_space
    return @current_space if defined? @current_space
    return session_space unless params[:redu_space_id]

    space_id = params[:redu_space_id]
    if session_space.try(:uid) == space_id.try(:to_i)
      @current_space ||= session_space
    else
      @space = Space.find_by_uid(params[:redu_space_id]) ||
        create_with_omniauth

      client = ReduClient.new(current_user.token,
                              params[:redu_space_id], current_user.uid)
      client.update_role
      session[:space_id] = @space.id
    end
  end

  def log_current_user
    Rails.logger.info "Current loged in user is: #{current_user.to_json}"
    Rails.logger.info "Current loged in space is: #{current_space.to_json}"
  end

  protected

  def create_with_omniauth
    client = ReduClient.new(current_user.token, params[:redu_space_id])
    response = client.get_space

    Space.create(name: JSON.parse(response.body)["name"],
                 uid: params[:redu_space_id])
  end
end
