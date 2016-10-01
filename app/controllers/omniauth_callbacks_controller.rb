class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    puts "*****************enter google_oauth2*************"
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: "google")
      sign_in(:user, @user)
      session[:user_id] = @user.id
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.google_data"] = oauth_response.except(:extra)
      params[:error] = :account_not_found
      do_failure_things
    end
  end
end
