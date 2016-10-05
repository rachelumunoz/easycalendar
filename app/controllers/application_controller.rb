require 'googleauth'
require 'googleauth/stores/redis_token_store'
require 'google/apis/calendar_v3'
require 'googleauth/stores/file_token_store'
require 'dotenv'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # def credentials_for(scope)
  #   authorizer = Google::Auth::WebUserAuthorizer.new(session[:client_id], scope, session[:token_store])
  #   user_id = session[:user_id]
  #   redirect root_path if user_id.nil?
  #   credentials = authorizer.get_credentials(user_id, request)
  #   if credentials.nil?
  #     redirect authorizer.get_authorization_url(login_hint: user_id, request: request)
  #   end
  #   credentials
  # # end

  # def google_login
  #   unless $event.get_credentials
  #   redirect_to('/oauth2callback')
  #   end
  # end



end
