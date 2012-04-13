# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :set_facebook_session
  helper_method :facebook_session
  helper_method :current_user

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def fetch_logged_in_user
    if facebook_session
      @current_user = User.find_by_fb_user(facebook_session.user)
    else
      return unless session[:user_id]
      @current_user = User.find_by_id(session[:user_id])
    end
  end

  def current_user
    session[:user]
  end
end
