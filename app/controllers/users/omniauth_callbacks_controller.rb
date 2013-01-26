class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    puts "ACCESS_TOKEN: #{ request.env["omniauth.auth"] }"
    @user = User.find_for_google_oauth2 request.env["omniauth.auth"], current_user
    sign_in_and_redirect @user, event: :authentication
  end
end

