class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.find_for_google_oauth2 request.env["omniauth.auth"], current_user
    sign_in_and_redirect @user, event: :authentication
  end

  def new_session_path(resource_name)
    root_path
  end
end

