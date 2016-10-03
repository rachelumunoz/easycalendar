class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # def after_sign_in_path_for(resource_or_scope)
  #  if request.env['omniauth.origin']
  #     request.env['omniauth.origin']
  #   end
  # end
end
