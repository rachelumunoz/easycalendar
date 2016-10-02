class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    puts "enter_user in application controller*****************************************************"
    if(@current_user)
      puts "current user already signed in!!!!!!!!!"
    end
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
