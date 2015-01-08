class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    return nil if Session.find_by(token: session[:session_token]).nil?
  
    @current_user ||= Session.find_by(token: session[:session_token]).user
  end

  def logged_in
    redirect_to new_session_url unless current_user
  end

  def login!(user)
    our_sesh = Session.create!(user_id: user.id)
    session[:session_token] = our_sesh.token
  end

end
