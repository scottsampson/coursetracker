class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :login_required, :except => [:login, :welcome, :authenticate, :fake_login]
  
  private
  
    def login_required
      user = User.find_by_username(session[:username])
      if user.nil? || session[:oauth_token] != user.oauth_token || session[:oauth_secret] != user.oauth_secret
        flash[:notice] = "You must be logged in to access that page."
        redirect_to '/'
      else
        @current_user = user
      end
    end
end
