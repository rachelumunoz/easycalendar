require 'googleauth/stores/redis_token_store'

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])
    puts "======find for google======"
    puts request.env["omniauth.auth"]
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"

      session[:user_id] = @user.id

      session[:client_id] = Google::Auth::ClientId.new(ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'])

      session[:token_store] = Google::Auth::Stores::RedisTokenStore.new(redis: Redis.new)

      session.inspect

      sign_in_and_redirect @user, :event => :authentication

    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
