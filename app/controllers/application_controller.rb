class ApplicationController < ActionController::Base
 helper_method :current_user, :logged_in?, :require_admin

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_admin
    unless current_user&.role == "admin"
      redirect_to login_path, alert: "Access denied."
    end
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Please log in first."
    end
  end
end
