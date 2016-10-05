class SessionsController < ApplicationController
  def create
    #@user = User.from_omniauth(env["omniauth.auth"])
    puts "hello from sessions controller"
    @current_user = User.find_or_create_from_auth_hash(auth_hash)
    @current_user = session[:user_id] = @user.id
    redirect_to root_path, :notice => "Signed in"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
