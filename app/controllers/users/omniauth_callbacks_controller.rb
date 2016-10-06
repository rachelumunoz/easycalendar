require 'googleauth/stores/redis_token_store'

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def passthru
    raise
  end

  def google_oauth2
    if params[:code]
      authorization = GoogleAuthorization.authorize(request.env['omniauth.auth'].info.email,
        request, params[:code])
    end

    @user = User.from_omniauth(request.env["omniauth.auth"])

    puts "======find for google======"
    puts request.env["omniauth.auth"]
    puts "======refresh token?======"
    puts request.env["omniauth.auth"]["refresh_token"]
    puts "==============token expiration========================="
    puts @user.token_expired?

    if @user.persisted?

      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      session[:user_id] = @user.id
      # target_url = Google::Auth::WebUserAuthorizer.handle_auth_callback_deferred(request)
      redirect_to '/profile'
    else
      puts "=========nope nope nope========="
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
