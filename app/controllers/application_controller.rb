class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def credentials_for(scope)
    authorizer = Google::Auth::WebUserAuthorizer.new(settings.client_id, scope, settings.token_store)
    user_id = session[:user_id]
    redirect root_path if user_id.nil?
    credentials = authorizer.get_credentials(user_id, request)
    if credentials.nil?
      redirect authorizer.get_authorization_url(login_hint: user_id, request: request)
    end
    credentials
  end

end
