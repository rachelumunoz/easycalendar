class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    puts "enter_user in applicatoin controller*****************************************************"
    if(@current_user)
      puts "current user already signed in!!!!!!!!!"
    end
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # def after_sign_in_path_for(resource_or_scope)
  #  if request.env['omniauth.origin']
  #     request.env['omniauth.origin']
  #   end
  # end
end
