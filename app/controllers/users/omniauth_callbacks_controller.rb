# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.from_omniauth(auth)

    if user.present?
      flash[:success] = t "devise.omniauth_callbacks.success", kind: "Google"
      sign_in_and_redirect user, event: :authentication
    else
      t "devise.omniauth_callbacks.failure", kind: "Google", reason: "Authentication failed"
      redirect_to new_user_registration_url
    end
  end

  private
  def auth
    @auth ||= request.env["omniauth.auth"]
  end
end
