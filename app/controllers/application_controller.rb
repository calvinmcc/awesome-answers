class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before_action :downcase_email

  def authenticate_user
    redirect_to new_session_path, alert: 'Please sign in' unless user_signed_in?
  end

  def user_signed_in?
    session[:user_id].present?
  end

  helper_method :user_signed_in?
  # adding this line makes this method accessible in the view files
  # because this method is in the application controller then it's
  # accessible to all views

  def current_user
    @current_user ||= User.find(session[:user_id]) if user_signed_in?
  end
  helper_method :current_user
  
end
