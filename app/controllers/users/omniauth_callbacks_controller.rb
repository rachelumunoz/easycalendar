class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
    puts "======find for google======"
    puts request.env["omniauth.auth"]
    session[:user_id] = user.id
    if @user
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"

      sign_in_and_redirect @user, :event => :authentication
      @user.token = request.env["omniauth.auth"].credentials[:token]
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
